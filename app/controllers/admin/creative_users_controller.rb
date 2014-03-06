class Admin::CreativeUsersController < Admin::BaseController

  def index
    @users = CreativeUser.all
  end
  
  def new
    @user = CreativeUser.new(in_queue: true)
  end

  def show
    @user = CreativeUser.find(params[:id])
  end

  def edit
    @user = CreativeUser.find(params[:id])
  end

  def create
    @user = CreativeUser.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name} has been created"
      redirect_to admin_creative_users_path
    else
      render 'new'
    end
  end

  def update
    @user = CreativeUser.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to admin_creative_users_path
    else
      render 'edit'
    end
  end

  def destroy
    @user = CreativeUser.find(params[:id])
    if @user == current_user
      flash[:error] = "You cannot delete yourself."
      redirect_to edit_admin_creative_user_path(@user)
    else
      @user.destroy
      flash[:success] = "CreativeUser removed."
      redirect_to admin_creative_users_path
    end
  end

  private

    def user_params
      params.require(:creative_user).permit!
    end


    def setup_nav_array
      @nav = ['creative_users']
    end
end
