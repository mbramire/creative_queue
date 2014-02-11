class CreativeUsersController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user, only: [:new, :create, :destroy]
  before_action :setup_nav_array

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
    unless current_user.admin || current_user == @user
      flash[:error] = "Requires admin privileges."
      redirect_to root_path
    end
  end

  def create
    @user = CreativeUser.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name} has been created"
      redirect_to creative_users_path
    else
      render 'new'
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

  def destroy
    @user = CreativeUser.find(params[:id])
    if @user == current_user
      flash[:error] = "You cannot delete yourself."
      redirect_to edit_creative_user_path(@user)
    else
      @user.destroy
      flash[:success] = "CreativeUser removed."
      redirect_to creative_users_url
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
