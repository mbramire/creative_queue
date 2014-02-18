class Badge < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :icon

  mount_uploader :icon, IconUploader
end
