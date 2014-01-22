class HomeController < ApplicationController
  before_action :setup_nav_array

  def index 
    if current_user
      @all_creative_users = CreativeUser.all
    end
  end

  private

    def setup_nav_array
      @nav = ['home']
    end
end
