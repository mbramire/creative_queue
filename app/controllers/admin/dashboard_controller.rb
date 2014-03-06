class Admin::DashboardController < Admin::BaseController
  def index
    redirect_to admin_creative_users_path
  end

  private

    def setup_nav_array
      @nav = ['home']
    end
end
