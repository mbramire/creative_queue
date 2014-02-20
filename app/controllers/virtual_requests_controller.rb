class VirtualRequestsController < ApplicationController
  before_action :signed_in_user
  before_action :setup_nav_array
  before_filter :only => [:edit, :destroy, :update, :quote_update, :add_quote] do |c| 
    c.admin_or_current_user params[:id]
  end

  def index 
    @virtual_requests = params[:search].nil? ? "" : VirtualRequest.search(params) 
  end

  def new 
    params = { creative_user_id: current_user.id, artist_id: nil }
    params[:artist_id] = current_user.id if current_user.artist
    @virtual_request = VirtualRequest.new(params)
  end

  def show
    @virtual_request = VirtualRequest.find(params[:id])
  end

  def edit
    @virtual_request = VirtualRequest.find(params[:id])
  end

  def add_quote
    @virtual_request = VirtualRequest.find(params[:id])
  end

  def quote_update
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.need_quote if params["virtual_request"]["creative_user_id"] == current_user.id.to_s
    @virtual_request.add_validations

    if @virtual_request.update(virtual_params)
      @virtual_request.create_actions
      
      flash[:success] = "Quote added"
      redirect_to root_path
    else
      render 'add_quote'
    end
  end

  def update
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.add_validations
    process = params[:commit] == "Save & Process"

    if process
      @virtual_request.require_company_info
    end
    
    if @virtual_request.update(virtual_params)
      @virtual_request.update_attributes(processed: true) if process
      @virtual_request.create_actions

      flash[:success] = "Virtual request updated"
      if @virtual_request.processed
        redirect_to virtual_request_path(@virtual_request)
      else 
        redirect_to root_path
      end
    else
      render 'edit'
    end
  end

  def create
    @virtual_request = VirtualRequest.new(virtual_params)
    @virtual_request.need_quote if @virtual_request.creative_user_id == current_user.id
    @virtual_request.add_validations

    if @virtual_request.save
      @virtual_request.create_actions
      flash[:success] = "Virtual has been created and is processing"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.destroy

    flash[:success] = "Virtual removed."
    redirect_to root_path
  end

  def move
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.update_attributes(artist_id: current_user.id, completed: false)

    flash[:success] = "#{@virtual_request.end_client} added to your queue."
    redirect_to virtual_request_path(@virtual_request)
  end

  def complete
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.update_attributes(completed: true)

    flash[:success] = "#{@virtual_request.end_client} marked as complete."
    redirect_to root_path
  end

  def duplicate
    @new_request = VirtualRequest.find(params[:id]).dup
    @new_request.make_copy(current_user)

    flash[:success] = "#{@new_request.end_client} has been created."
    redirect_to edit_virtual_request_path(@new_request)
  end

  def download_file
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    send_file(@virtual_request.art.url,
          disposition: 'attachment',
          url_based_filename: false)
  end

  private

    def virtual_params
      params.require(:virtual_request).permit!
    end

    def setup_nav_array
      @nav = params[:action] == "index" ? ['search'] : ['home']
    end
end
