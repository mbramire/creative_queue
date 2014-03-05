class CreativeUser < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i   
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :unless => :password_not_needed?
  validates :phone_number,  presence: true
  
  has_secure_password

  before_save { self.name = name.titlecase }
  before_create :create_remember_token

  mount_uploader :avatar, AvatarUploader

  has_many :virtual_requests
  has_many :virtuals
  has_many :awarded_badges
  belongs_to :title

  by_star_field :updated_at
  
  def homepage
    case self.account_type
    when "Journalbooks"
      journalbooks_virtual_requests_path
    end
  end

  def CreativeUser.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def CreativeUser.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def password_not_needed?
    action_name = 'edit' && password.blank?
  end

  def first_name
    self.name.split(' ')[0]
  end

  def short_name
    new_name = self.name.split(" ")
    first = new_name[0]
    last = new_name[1][0] + "." unless new_name[1].nil?
    "#{first} #{last}"
  end
  
  def owns?(virtual, admin=true)
    if admin
      self.id == virtual.creative_user_id || self.id == virtual.artist_id || self.admin
    else
     self.id == virtual.creative_user_id || self.id == virtual.artist_id
    end 
  end

  def artist_for?(virtual)
    self.id == virtual.artist_id
  end

  def artist_or_admin_for?(virtual)
    self.id == virtual.artist_id || self.admin
  end

  def requested?(virtual)
    self.id == virtual.creative_user_id
  end
  
  def sales_and_artist
    self.sales && self.artist
  end

  def no_queue?
    !self.artist && !self.sales
  end
  

  def self.artists
    CreativeUser.where(artist: true)
  end

  def self.sales
    CreativeUser.where(sales: true) 
  end

  def self.quoters
    all = CreativeUser.sales + CreativeUser.artists
    all.uniq { |v| v[:id] }
  end

  def self.artists_in_queue
    CreativeUser.where(artist: true, in_queue: true)
  end

  def self.sales_in_queue
    CreativeUser.where(sales: true, in_queue: true)
  end

  def self.quoters_in_queue
    all = CreativeUser.sales_in_queue + CreativeUser.artists_in_queue
    all.uniq { |v| v[:id] }
  end

  def requests_with(artist)
    self.virtual_requests.find_all { |a| a.artist_id == artist.id }
  end
  
  def avatar_image 
    self.avatar.present? ? self.avatar : "profile/avatar.png"
  end

  def vr_current_month
    VirtualRequest.where(artist_id: self.id, completed: true, updated_at: Time.new.all_month)
  end

  def vr_ordered_current_month
    VirtualRequest.where(artist_id: self.id, ordered: true, updated_at: Time.new.all_month)
  end

  def vr_assigned
    VirtualRequest.where(artist_id: self.id, completed: false)
  end

  def vr_completed
    VirtualRequest.where(artist_id: self.id, completed: true) 
  end

  def vr_ordered
    VirtualRequest.where(artist_id: self.id, ordered: true) 
  end

  def requests_current_month
    VirtualRequest.where(creative_user_id: self.id, completed: true, updated_at: Time.new.all_month)
  end

  def requests_ordered_current_month
    VirtualRequest.where(creative_user_id: self.id, ordered: true, updated_at: Time.new.all_month)
  end

  def requests_quoted
    quoted = VirtualRequest.where(creative_user_id: self.id, completed: false)
  end

  def requests_completed
    VirtualRequest.where(creative_user_id: self.id, completed: true).order("updated_at DESC")
  end

  def requests_needing_quote
    VirtualRequest.where(creative_user_id: self.id, quote: nil).order("updated_at DESC") 
  end

  def requests_ordered
    VirtualRequest.where(creative_user_id: self.id, ordered: true) 
  end

  def queued_requests
    all = self.vr_assigned + self.requests_quoted + self.requests_needing_quote
    unduped = all.uniq { |v| v[:id] }
    unduped.sort_by &:due_date
  end

  def recently_completed
    all = self.requests_completed.limit(30) + self.vr_completed.limit(30)
    all.uniq { |v| v[:id] }
  end

  def completed_stat
    self.artist ? self.vr_completed.count : self.requests_completed.count
  end

  def virtual_totals
    art = VirtualRequest.where(artist_id: self.id, completed: false).count
    sales = VirtualRequest.where(creative_user_id: self.id, completed: false).count
    art + sales
  end

  def name_vrs
    "#{'(zzz) ' unless self.in_queue}#{self.name} (#{self.vr_assigned.count})"
  end

  def name_requests
    "#{'(zzz) ' unless self.in_queue}#{self.name} (#{self.requests_quoted.count})"
  end

  def title_update
    completed = self.artist ? self.vr_completed.count : self.requests_completed.count

    unless self.last_title?
      next_title_id = self.title_id + 1
      next_title = Title.find(next_title_id)

      if completed >= next_title.value
        new_title = next_title.id
        self.update_attributes(title_id: new_title)
        AwardedBadge.create!(creative_user_id: self.id, badge_id: 1)
      end 
    end
  end

  def next_title
    nxt = self.title.id + 1
    Title.find(nxt)
  end

  def prev_title
    prev = self.title.id - 1
    Title.find(prev)
  end

  def last_title?
    self.title == Title.all.last
  end

  def has_badge?(badge)
    self.awarded_badges.where(badge_id: badge.id).any?
  end

  def badge_count(badge)
    self.awarded_badges.where(badge_id: badge.id).count
  end

  private

    def create_remember_token
      self.remember_token = CreativeUser.encrypt(CreativeUser.new_remember_token)
    end
end
