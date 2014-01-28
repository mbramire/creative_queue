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
  
  def self.artist_in_queue
    CreativeUser.where(in_queue: true, artist: true)
  end

  def self.sales_in_queue
    CreativeUser.where(in_queue: true, sales: true) 
  end

  def requests_with(artist)
    self.virtual_requests.find_all { |a| a.artist_id == artist.id }
  end
  
  def avatar_image 
    self.avatar.present? ? self.avatar : "profile/avatar.png"
  end

  def virtuals_this_month
    self.virtuals.find_all { |v| v.updated_at.strftime("%B") == Time.new.strftime("%B") }.count
  end

  def requests_this_month
    self.virtual_requests.find_all { |v| v.updated_at.strftime("%B") == Time.new.strftime("%B") }.count
  end

  def converted_all_time
  end

  def converted_this_month
  end

  def vr_to_work_on
    VirtualRequest.where(artist_id: self.id, completed: false, processed: true).where.not(quote: nil)
  end

  def vr_completed
    VirtualRequest.where(artist_id: self.id, completed: true) 
  end

  def requests_pending
    VirtualRequest.where(creative_user_id: self.id, completed: false, processed: true).where.not(quote: nil) 
  end

  def requests_completed
    VirtualRequest.where(creative_user_id: self.id, completed: true) 
  end

  def requests_needing_quote
    VirtualRequest.where(creative_user_id: self.id, quote: nil, processed: true) 
  end

  private

    def create_remember_token
      self.remember_token = CreativeUser.encrypt(CreativeUser.new_remember_token)
    end
end
