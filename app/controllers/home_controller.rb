class HomeController < ApplicationController
  before_action :setup_nav_array

  def index 
    if current_user
      @vr_to_work_on = VirtualRequest.where(artist_id: current_user.id, completed: false)
      @vr_completed = VirtualRequest.where(artist_id: current_user.id, completed: true)
      @vr_made = VirtualRequest.where(creative_user_id: current_user.id, completed: false)
      @vr_made_and_completed = VirtualRequest.where(creative_user_id: current_user.id, completed: true)
      @all_creative_users = CreativeUser.all
    end
  end

  private

    def setup_nav_array
      @nav = ['home']
    end
end
