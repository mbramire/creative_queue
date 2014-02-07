class CreativeUser < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i 
  TITLES = ["Apprentice", "CrackerJack", "Virtual Pro", "Maestro", "Visionary", "Czar", "Virtual Jedi"] 
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :unless => :password_not_needed?
  validates :phone_number,  presence: true, 
                            length: { maximum: 10, minimum: 10 }, 
                            :numericality => {:only_integer => true}
  
  has_secure_password

  before_save { self.name = name.titlecase }
  before_create :create_remember_token

  mount_uploader :avatar, AvatarUploader

  has_many :virtual_requests
  has_many :virtuals
  
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

  def filter_phone_number
    new_num = self.phone_number.insert(3, ".").insert(7, ".")
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

  def requested?(virtual)
    self.id == virtual.creative_user_id
  end
  
  def sales_and_artist
    self.sales && self.artist
  end
  
  def self.artist_in_queue
    CreativeUser.where(in_queue: true, artist: true)
  end

  def self.sales_in_queue
    CreativeUser.where(in_queue: true, sales: true) 
  end

  def self.in_queue
    CreativeUser.where(in_queue: true)
  end

  def requests_with(artist)
    self.virtual_requests.find_all { |a| a.artist_id == artist.id }
  end
  
  def avatar_image 
    self.avatar.present? ? self.avatar : "profile/avatar.png"
  end

  def vr_current_month
    VirtualRequest.where(artist_id: self.id, completed: true).by_month(Time.new.strftime("%B"))
  end

  def vr_ordered_current_month
    VirtualRequest.where(artist_id: self.id, ordered: true).by_month(Time.new.strftime("%B"))
  end

  def vr_assigned
    ready = VirtualRequest.where(artist_id: self.id, completed: false, processed: true)
    need_quote = VirtualRequest.where(creative_user_id: self.id, completed: false, quote: nil)
    ready + need_quote
  end

  def vr_processing
    VirtualRequest.where(artist_id: self.id, processed: false).where("quote > ?", 0)
  end

  def vr_completed
    VirtualRequest.where(artist_id: self.id, completed: true) 
  end

  def vr_ordered
    VirtualRequest.where(artist_id: self.id, ordered: true) 
  end

  def requests_current_month
    VirtualRequest.where(creative_user_id: self.id, completed: true).by_month(Time.new.strftime("%B"))
  end

  def requests_ordered_current_month
    VirtualRequest.where(creative_user_id: self.id, ordered: true).by_month(Time.new.strftime("%B"))
  end

  def requests_quoted
    quoted = VirtualRequest.where(creative_user_id: self.id, completed: false)
    need_quote = quoted.where(quote: nil)
    ready = quoted.where(processed: true)
    ready + need_quote
  end

  def requests_processing
    VirtualRequest.where(creative_user_id: self.id, processed: false).where("quote > ?", 0)
  end

  def requests_completed
    VirtualRequest.where(creative_user_id: self.id, completed: true) 
  end

  def requests_needing_quote
    VirtualRequest.where(creative_user_id: self.id, quote: nil) 
  end

  def requests_ordered
    VirtualRequest.where(artist_id: self.id, ordered: true) 
  end

  def queued_requests
    all = self.vr_assigned + self.requests_quoted
    all.uniq { |v| v[:id] }
  end

  def virtual_totals
    art = VirtualRequest.where(artist_id: self.id, completed: false).count
    sales = VirtualRequest.where(creative_user_id: self.id, completed: false).count
    art + sales
  end

  def name_vrs
    "#{self.name} (#{self.vr_assigned.count})"
  end

  def name_requests
    "#{self.name} (#{self.requests_quoted.count})"
  end

  private

    def create_remember_token
      self.remember_token = CreativeUser.encrypt(CreativeUser.new_remember_token)
    end
end
