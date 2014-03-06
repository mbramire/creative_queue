class HomeController < ApplicationController
  before_action :setup_nav_array

  def index 
  end

  private

    def setup_nav_array
      @nav = ['home']
    end
end
