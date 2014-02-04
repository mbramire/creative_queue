class VirtualRequest < ActiveRecord::Base
  validates_presence_of :quantity
  validates_presence_of :budget
  validates_presence_of :end_client
  validates_presence_of :unformatted_date, if: :need_due_date?
  #FIXME the validation will fail but the record is still created without due_date
  validates_presence_of :creative_user_id
  validates_presence_of :artist_id
  validates_presence_of :art, unless: :art_website?, message: "url or art file must be provided"
  validates_presence_of :quote, if: :need_quote?, message: "must be provided"
  validates_uniqueness_of :quote, if: :need_quote?

  belongs_to :creative_user
  belongs_to :artist, class_name: CreativeUser
  belongs_to :user
  # belongs_to :distributor

  has_many :virtuals, dependent: :destroy

  mount_uploader :art, VirtualArtUploader
  
  before_save :update_art_attributes
  before_save :format_date, :if => :need_due_date?

  default_scope { order('priority DESC, due_date ASC') }

  attr_accessor  :unformatted_date

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
    date = self.due_date.strftime("%m/%d/%y")
    if due_date < 4.business_days.from_now && !self.completed
      "<em class='alert-text'>#{date}</em>".html_safe
    else 
      date
    end
  end

  def apply_user
    jb_user = User.where(email: self.contact_email)
    self.user_id = jb_user.first.id unless jb_user.first.nil?
    self.save
  end

  def auto_assign!
    if self.artist_id == 0
      artists = CreativeUser.artist_in_queue.collect {|p| [ p.id, p.vr_assigned.count ] } 
      self.artist_id = artists.sort { |a,b| a[1] <=> b[1] }.first[0]
      self.save
    end

    if self.creative_user_id == 0
      sales = CreativeUser.sales_in_queue.collect {|p| [ p.id, p.requests_assigned.count ] } 
      self.creative_user_id = sales.sort { |a,b| a[1] <=> b[1] }.first[0]
      self.save
    end
  end

  def format_date
    self.due_date = Date.strptime(self.unformatted_date, "%m/%d/%Y").to_time(:local)
  end

  def need_due_date
    @need_date = true
  end

  def need_due_date?
    @need_date
  end

  def need_quote
    @quote = true
  end

  def need_quote?
    @quote
  end

  def make_copy(user)
    self.completed = false
    self.end_client = self.end_client + " (copy)" unless self.end_client.include? "(copy)"
    self.creative_user_id = user.id
    self.save
  end

  def check_priority
    rules = Rule.all
    clean_company = self.company.split(" ")[0].downcase

    rules.each do |r|
      if r.company.downcase == clean_company || r.email.downcase == self.contact_email.downcase || r.name.downcase == contact_name.downcase
        self.update_attributes(priority: true)
      end
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