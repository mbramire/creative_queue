class VirtualsController < ApplicationController
  before_action :signed_in_user
  before_action :setup_nav_array
  before_action { |c| c.admin_or_current_user params[:virtual_request_id] }

  def new 
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    @virtual = Virtual.new
  end

  def edit
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    @virtual = Virtual.find(params[:id])
    admin_or_current_user(@virtual_request)
  end

  def update
    @virtual = Virtual.find(params[:id])
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])

    if @virtual.update(virtual_params)
      flash[:success] = "Virtual updated"
      redirect_to virtual_request_path(@virtual_request)
    else
      render 'edit'
    end
  end

  def create
    @virtual = Virtual.new(virtual_params)
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])

    if @virtual.save
      flash[:success] = "Virtual has been created for #{@virtual_request.company}"
      redirect_to virtual_request_path(@virtual_request)
    else
      render 'new'
    end
  end

  def destroy
    @virtual = Virtual.find(params[:id])
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    @virtual.destroy
    flash[:success] = "Virtual removed."
    redirect_to virtual_request_path(@virtual_request)
  end

  private

    def virtual_params
      params.require(:virtual).permit!
    end

    def setup_nav_array
      @nav = ['virtuals']
    end
end
