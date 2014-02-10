class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :registerable,
  # :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  belongs_to :distributor
  has_many :virtual_requests

  before_create :generate_user_password

  delegate :orders, :customer_number, :asi_number, :ppi_number, :artwork,
            :address_1, :address_2, :city, :state, :postal_code, :country,
            :to => :distributor

  alias_method :company, :distributor

  validates :email, :uniqueness => true

  def can_edit_company_info?
    customer_number.present? && customer_number != 0
  end

  # for dist form
  def delete_user
    0
  end

  def delete_user=(val)
    true
  end

  def name 
    "#{self.first_name} #{self.last_name}"
  end

  def invoicee?
    self.email.downcase == self.company.invoicee_email.downcase unless self.company.invoicee_email.nil?
  end

  def name_with_company
    "#{self.name} / #{self.company.try(:name)}"
  end

  # Authenticates a user by their email address and password.  Returns the user or nil.
  def self.authenticate(email, password)
    user = User.find_by_email_and_password(email, password, :conditions=>"password IS NOT NULL AND password!=''")
    # return nil unless user.customer_number.present?
    user.update_attribute(:last_login_at, Time.now) if user.present?
    user
  end

  # def random_password(len=6)
  #   chars = %w(2 3 4 5 6 7 8 9 a b c d e f g h j k m n p q r s t u v w x y z A B C D E F G H J K M N P Q R S T U V W X Y Z)
  #   word = ''
  #   1.upto(len) do |i|
  #     word << chars[rand(chars.size)]
  #   end
  #   word
  # end

private
  def generate_user_password
    return if self.password.present?
    self.password = self.random_password
  end
end
