class VirtualRequestsController < ApplicationController
  before_action :signed_in_user
  before_action :setup_nav_array
  before_filter :only => [:edit, :destroy, :update] do |c| 
    c.admin_or_current_user params[:id]
  end

  def index 
    @virtuals = VirtualRequest.all
  end

  def new 
    @virtual_request = VirtualRequest.new
  end

  def show
    @virtual_request = VirtualRequest.find(params[:id])
  end

  def edit
    @virtual_request = VirtualRequest.find(params[:id])
  end

  def update
    @virtual_request = VirtualRequest.find(params[:id])

    if @virtual_request.update(virtual_params)
      @virtual_request.auto_assign!
      @virtual_request.apply_user
      
      flash[:success] = "Virtual request updated"
      redirect_to virtual_request_path(@virtual_request)
    else
      render 'edit'
    end
  end

  def create
    @virtual_request = VirtualRequest.new(virtual_params)
    @virtual_request.apply_user
    @virtual_request.auto_assign!

    if @virtual_request.save
      flash[:success] = "Virtual has been created and assigned to #{@virtual_request.artist.name}"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.destroy

    flash[:success] = "Virtual removed."
    redirect_to virtual_requests_path
  end

  def move
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.update_attributes(artist_id: current_user.id, completed: false)

    flash[:success] = "#{@virtual_request.company} added to your queue."
    redirect_to virtual_request_path(@virtual_request)
  end

  private

    def virtual_params
      params.require(:virtual_request).permit!
    end

    def setup_nav_array
      @nav = ['virtuals']
    end
end
