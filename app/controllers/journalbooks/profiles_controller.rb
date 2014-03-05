class Journalbooks::ProfilesController < Journalbooks::BaseController

  def index
    @users = CreativeUser.all
  end

  def show
    @user = CreativeUser.find(params[:id])
    @badges = Badge.all
  end

  def edit
    @user = CreativeUser.find(params[:id])
    unless current_user.admin || current_user == @user
      flash[:error] = "Requires admin privileges."
      redirect_to journalbooks_virtual_requests_path
    end
  end

  def update
    @user = CreativeUser.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to creative_user_path(@user)
    else
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:creative_user).permit!
    end


    def setup_nav_array
      @nav = ['profiles']
    end
end
