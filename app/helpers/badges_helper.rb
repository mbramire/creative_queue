module BadgesHelper

  def new_badges?
    new_badges.any?
  end

  def new_badges
    if current_user
      AwardedBadge.where(creative_user_id: current_user.id, notified: false)
    end
  end

  def mark_notified(badge)
    badge.update_attributes(notified: true)
  end
end