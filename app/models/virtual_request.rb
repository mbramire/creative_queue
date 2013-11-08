class VirtualRequest < ActiveRecord::Base
  validates_presence_of :contact_name
  validates_presence_of :contact_email
  validates_presence_of :contact_phone
  validates_presence_of :quantity
  validates_presence_of :budget
  validates_presence_of :company
  validates_presence_of :due_date
  validates_presence_of :creative_user_id
  validates_presence_of :artist_id
  validates_presence_of :art, :unless => :art_website?, :message => "url or art file must be provided"

  belongs_to :creative_user
  belongs_to :artist, class_name: CreativeUser
  belongs_to :user
  # belongs_to :distributor

  has_many :virtuals, dependent: :destroy

  mount_uploader :art, VirtualArtUploader
  
  before_save :update_art_attributes

  default_scope { order('priority ASC, due_date ASC') }

  def requested_by
    self.creative_user_id.present? ? self.creative_user.name : self.contact_name
  end
  
  def filter_art_website
    unless self.art_website.include? "://"
      "http://" + self.art_website
    else
      self.art_website
    end
  end

  def contact_info
    self.contact_name + " - " + self.contact_email
  end

  def due_date_human
    self.due_date.strftime("%m/%d/%y")
  end

  def apply_user
    jb_user = User.where(email: self.contact_email)
    self.user_id = jb_user.first.id unless jb_user.first.nil?
    self.save
  end

  def auto_assign!
    if self.artist_id == 0
      artists = CreativeUser.in_queue?.collect {|p| [ p.id, p.virtual_requests_artist_for ] } 
      self.artist_id = artists.sort { |a,b| a[1] <=> b[1] }.first[0]
      self.save
    end
  end

private

  def update_art_attributes
    if art.present? && art_changed?
      self.art_content_type = art.file.content_type
      self.art_file_size = art.file.size
    end
  end
end