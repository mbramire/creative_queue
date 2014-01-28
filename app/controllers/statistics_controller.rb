class StatisticsController < ApplicationController
  before_action :setup_nav_array

  def index 
    if current_user
      @artists = CreativeUser.where(artist: true)
      @sales = CreativeUser.where(sales: true)
    end
  end

  private

    def setup_nav_array
      @nav = ['statistics']
    end
end
