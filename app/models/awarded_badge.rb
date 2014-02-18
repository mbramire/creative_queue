class AwardedBadge < ActiveRecord::Base
  validates_presence_of :creative_user_id
  validates_presence_of :badge_id

  belongs_to :badges
  belongs_to :creative_user
end
