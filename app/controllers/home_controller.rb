class HomeController < ApplicationController
  before_action :setup_nav_array

  def index
    if current_user
      send_home(current_user)
    end 
  end

  private

    def setup_nav_array
      @nav = ['home']
    end
end
