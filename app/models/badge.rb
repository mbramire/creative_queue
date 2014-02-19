class Badge < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :icon

  mount_uploader :icon, IconUploader

  def self.assign_badges!(virtual)
    virtual.artist.title_update
    virtual.creative_user.title_update
    #virtualocity(virtual.artist)
  end

  #Badges
  def virtualocity(user)
    if user.vr_completed.today.count == 10
      AwardedBadge.new(badge_id: 2, creative_user_id: user.id)
    end
  end

  def virtualocity(user)
    if user.vr_completed.today.count == 10
      AwardedBadge.new(badge_id: 2, creative_user_id: user.id)
    end
  end
end
