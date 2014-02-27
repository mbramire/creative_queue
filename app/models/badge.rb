class Badge < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :icon

  mount_uploader :icon, IconUploader

  def self.assign_badges!(virtual)
    virtual.artist.title_update
    virtual.creative_user.title_update
    Badge.virtualocity(virtual.artist)
    Badge.master(virtual.artist)
    Badge.amazing(virtual.artist)
    Badge.cha_ching(virtual.artist)
    Badge.cha_ching(virtual.creative_user)
    Badge.closer(virtual.artist)
    Badge.closer(virtual.creative_user)
    Badge.please(virtual)
    Badge.damn(virtual)
  end

  #Badges
  def self.virtualocity(user)
    if user.virtuals.today.count == 10 && !user.awarded_badges.where(badge_id: 2).today.any?
      AwardedBadge.create!(badge_id: 2, creative_user_id: user.id)
    end
  end

  def self.master(user)
    if user.virtuals.by_week.count == 40 && !user.awarded_badges.where(badge_id: 3).by_week.any?
      AwardedBadge.create!(badge_id: 3, creative_user_id: user.id)
    end
  end

  def self.amazing(user)
    if user.virtuals.by_month.count == 125 && !user.awarded_badges.where(badge_id: 4).by_month.any?
      AwardedBadge.create!(badge_id: 4, creative_user_id: user.id)
    end
  end

  def self.cha_ching(user)
    if user.sales
      if user.requests_ordered.by_week.count == 2 && !user.awarded_badges.where(badge_id: 5).by_week.any?
        AwardedBadge.create!(badge_id: 5, creative_user_id: user.id)
      end
    else
      if user.vr_ordered.by_week.count == 2 && !user.awarded_badges.where(badge_id: 5).by_week.any?
        AwardedBadge.create!(badge_id: 5, creative_user_id: user.id)
      end
    end
  end

  def self.closer(user)
    if user.sales
      if user.requests_ordered.by_month.count == 6 && !user.awarded_badges.where(badge_id: 6).by_month.any?
        AwardedBadge.create!(badge_id: 6, creative_user_id: user.id)
      end
    else
      if user.vr_ordered.by_month.count == 6 && !user.awarded_badges.where(badge_id: 6).by_month.any?
        AwardedBadge.create!(badge_id: 6, creative_user_id: user.id)
      end
    end
  end

  def self.please(virtual)
    if virtual.virtuals.count == 4 
      AwardedBadge.create!(badge_id: 7, creative_user_id: virtual.artist.id)
    end
  end

  def self.damn(virtual)
    if virtual.virtuals.count == 6 
      AwardedBadge.create!(badge_id: 8, creative_user_id: virtual.artist.id)
    end
  end
end
