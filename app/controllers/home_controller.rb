class HomeController < ApplicationController
  before_action :setup_nav_array

  def index 
    if current_user
      if current_user.no_queue?
        redirect_to virtual_requests_path
      end
      @artists = CreativeUser.where(artist: true)
      @sales = CreativeUser.where(sales: true)
    end
  end

  private

    def setup_nav_array
      @nav = ['home']
    end
end
