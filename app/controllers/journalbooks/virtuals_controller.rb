class Journalbooks::VirtualsController < Journalbooks::BaseController
  before_action { |c| c.admin_or_current_user params[:virtual_request_id] }
  # before_action :virtual_editable?, only: [:edit, :update]

  def new 
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    @virtual = Virtual.new
  end

  def edit
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    @virtual = Virtual.find(params[:id])
    @email_addresses = @virtual.recipients
  end

  def update
    @virtual = Virtual.find(params[:id])
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])

    if @virtual.update(virtual_params)
      flash[:success] = "Virtual updated"
      redirect_to journalbooks_virtual_request_path(@virtual_request)
    else
      render 'edit'
    end
  end

  def create
    @virtual = Virtual.new(virtual_params)
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])

    if @virtual.save
      flash[:success] = "Virtual has been created for #{@virtual_request.end_client}"
      redirect_to journalbooks_virtual_request_path(@virtual_request)
    else
      render 'new'
    end
  end

  def destroy
    @virtual = Virtual.find(params[:id])
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    @virtual.destroy
    flash[:success] = "Virtual removed."
    redirect_to journalbooks_virtual_request_path(@virtual_request)
  end

  def send_out
    @virtual_request = VirtualRequest.find(params[:virtual_request_id])
    @virtual = Virtual.find(params[:id])
    @recipients = @virtual.recipients
    @sender = current_user
    
    DistributorMailer.virtual_email(@virtual, @virtual_request, @recipients, @sender).deliver
    flash[:success] = "#{@virtual_request.end_client}#{@virtual.version_display} has been sent to #{@recipients}."
    @virtual.update_attributes(sent: Time.now)
    @virtual_request.update_attributes(completed: true)
    Badge.assign_badges!(@virtual_request)
    redirect_to journalbooks_virtual_requests_path
  end

  private
    def virtual_editable?
      virtual = Virtual.find(params[:id])
      request = VirtualRequest.find(params[:virtual_request_id])
      if virtual.sent
        flash[:error] = "This virtual has already been sent and cannot be edited, you need to create a new version."
        redirect_to journalbooks_virtual_request_path(request)
      end
    end

    def virtual_params
      params.require(:virtual).permit!
    end

    def setup_nav_array
      @nav = ['home']
    end
end
