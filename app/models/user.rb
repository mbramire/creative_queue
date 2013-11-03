class User < ActiveRecord::Base
  has_many :virtual_requests
end
