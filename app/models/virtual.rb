class Virtual < ActiveRecord::Base
  belongs_to :virtual_request
  belongs_to :creative_user 

  before_validation do
    emails = self.recipients.downcase.split(/[\s,]+/)

    emails.each do |email|
      self.errors.add(:recipients, "has an invalid email address or is missing a comma") unless email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
    end
    self.recipients = emails.join(", ")
  end

  validates_presence_of :virtual_request_id
  validates_presence_of :creative_user_id
  validates_presence_of :document
  validates_presence_of :recipients
  validates_presence_of :version
  #validates_presence_of :quote_number
  validate :document_size_validation, :if => :document? 

  before_save :update_document_attributes
  before_create :set_version

  mount_uploader :document, DocumentUploader

  default_scope { order('created_at DESC') }

  def completed_date
    self.updated_at.strftime("%m/%d/%y")
  end

  def sent_date
    self.sent.strftime("%m/%d/%y at %l:%M %P")
  end

  def version_display
    v = self.version - 1
    " (#{v.ordinalize} revision)" unless v == 0
  end

  private
    def document_size_validation
      errors[:document] << "should be less than 10MB" if document.file.size > 10.megabytes
    end

    def set_version
      previous = Virtual.where(virtual_request_id: virtual_request_id)
      self.version = previous.first.version + 1 unless previous.empty?
    end

    def update_document_attributes
      if document.present? && document_changed?
        self.document_content_type = document.file.content_type
        self.document_file_size = document.file.size
      end
    end
end