class Virtual < ActiveRecord::Base
  belongs_to :virtual_request
  belongs_to :creative_user 

  before_validation do
    emails = self.recipients.downcase.split(/[\s,]+/)

    emails.each do |email|
      self.errors.add(:recipients, "has an invalid email address or is missing a comma") unless email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i  
    end
    self.recipients = emails.join(",")
  end

  validates_presence_of :document
  validates_presence_of :recipients
  validate :document_size_validation, :if => :document? 

  before_save :update_document_attributes
  before_save :set_version

  mount_uploader :document, DocumentUploader

  def completed_date
    self.updated_at.strftime("%m/%d/%y")
  end

  private
    def document_size_validation
      errors[:document] << "should be less than 10MB" if document.file.size > 10.megabytes
    end

    def set_version
      new_version = Virtual.where(virtual_request_id: virtual_request_id)
      self.version = new_version.empty? ? 1 : new_version.last.version + 1 
    end

    def update_document_attributes
      if document.present? && document_changed?
        self.document_file_type = document.file.content_type
        self.document_file_size = document.file.size
      end
    end
end