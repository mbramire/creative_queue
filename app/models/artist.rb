class Artist < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i 
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, 
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }, :unless => :password_not_needed?
  
  has_secure_password

  before_save { self.name = name.titlecase }
  before_create :create_remember_token

  mount_uploader :avatar, AvatarUploader

  has_many :virtual_requests
  has_many :virtuals

  def owns?(virtual)
    self.id == virtual.artist_id
  end
  
  def Artist.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Artist.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def password_not_needed?
    action_name = 'edit' && password.blank?
  end

  def first_name
    self.name.split(' ')[0]
  end
  
  def self.in_queue?
    Artist.where(in_queue: true)
  end
  
  def avatar_image 
    self.avatar.present? ? self.avatar : "profile/avatar.png"
  end

  def virtuals_this_month
    self.virtuals.find_all { |v| v.updated_at.strftime("%B") == Time.new.strftime("%B") }.count
  end

  private

    def create_remember_token
      self.remember_token = Artist.encrypt(Artist.new_remember_token)
    end
end
