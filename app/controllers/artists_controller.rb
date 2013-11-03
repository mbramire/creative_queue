class ArtistsController < ApplicationController
  before_action :signed_in_user
  before_action :admin_user, only: [:new, :create, :destroy]
  before_action :setup_nav_array

  def index
    @users = Artist.all
  end
  
  def new
    @user = Artist.new
  end

  def show
    @user = Artist.find(params[:id])
  end

  def edit
    @user = Artist.find(params[:id])
    unless current_user.admin || current_user == @user
      flash[:error] = "Requires admin privledges."
      redirect_to root_path
    end
  end

  def create
    @user = Artist.new(user_params)
    if @user.save
      flash[:success] = "#{@user.name} has been created"
      redirect_to artists_path
    else
      render 'new'
    end
  end

  def update
    @user = Artist.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to artist_path(@user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = Artist.find(params[:id])
    if @user == current_user
      flash[:error] = "You cannot delete yourself."
      redirect_to edit_artist_path(@user)
    else
      @user.destroy
      flash[:success] = "Artist removed."
      redirect_to artists_url
    end
  end

  private

    def user_params
      params.require(:artist).permit!
    end


    def setup_nav_array
      @nav = ['artists']
    end
end
