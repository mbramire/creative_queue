class VirtualRequestsController < ApplicationController
  before_action :signed_in_user
  before_action :setup_nav_array
  before_filter :only => [:edit, :destroy, :update] do |c| 
    c.admin_or_current_user params[:id]
  end

  def index 
    @virtuals = VirtualRequest.all.where(completed: false)
    @virtuals_completed = VirtualRequest.all.where(completed: true)
  end

  def new 
    @new_virtual_request = VirtualRequest.new
  end

  def artist_new 
    @new_virtual_request = VirtualRequest.new
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
    @virtual_request.need_due_date
    @virtual_request.need_quote

    if @virtual_request.update(virtual_params)
      @virtual_request.auto_assign!
      @virtual_request.apply_user
      
      flash[:success] = "Quote added"
      redirect_to root_path
    else
      render 'add_quote'
    end
  end

  def update
    @virtual_request = VirtualRequest.find(params[:id])
    @virtual_request.need_due_date
    @virtual_request.need_quote

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
    @new_virtual_request = VirtualRequest.new(virtual_params)
    @new_virtual_request.need_quote
    @new_virtual_request.need_due_date
    @new_virtual_request.apply_user
    @new_virtual_request.auto_assign!

    if @new_virtual_request.save
      flash[:success] = "Virtual has been created and assigned to #{@virtual_request.artist.name}"
      redirect_to root_path
    else
      render 'new'
    end
  end

  def artist_create
    @new_virtual_request = VirtualRequest.new(virtual_params)
    @new_virtual_request.need_due_date
    @new_virtual_request.apply_user
    @new_virtual_request.auto_assign!
    
    if @new_virtual_request.creative_user_id.nil? && @new_virtual_request.quote
      @new_virtual_request.creative_user_id = current_user.id
    elsif @new_virtual_request.creative_user_id.nil?
      @new_virtual_request.need_quote
    end

    if @new_virtual_request.save
      flash[:success] = "Virtual has been created and is being processed"
      redirect_to root_path
    else
      render 'artist_new'
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

    flash[:success] = "#{@virtual_request.company} added to your queue."
    redirect_to virtual_request_path(@virtual_request)
  end

  def duplicate
    @new_request = VirtualRequest.find(params[:id]).dup
    @new_request.make_copy(current_user)

    flash[:success] = "#{@new_request.company} has been created."
    redirect_to edit_virtual_request_path(@new_request)
  end

  def download_file
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    send_file(@virtual_request.art.path,
          disposition: 'attachment',
          url_based_filename: false)
  end

  private

    def virtual_params
      params.require(:virtual_request).permit!
    end

    def setup_nav_array
      @nav = ['virtuals']
    end
end
