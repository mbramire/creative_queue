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

  def virtual_requests_artist_for
    VirtualRequest.where(artist_id: self.id).count
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
  
  def self.in_queue?
    CreativeUser.where(in_queue: true)
  end
  
  def avatar_image 
    self.avatar.present? ? self.avatar : "profile/avatar.png"
  end

  def virtuals_this_month
    self.virtuals.find_all { |v| v.updated_at.strftime("%B") == Time.new.strftime("%B") }.count
  end

  def converted_all_time
  end

  def converted_this_month
  end

  private

    def create_remember_token
      self.remember_token = CreativeUser.encrypt(CreativeUser.new_remember_token)
    end
end
