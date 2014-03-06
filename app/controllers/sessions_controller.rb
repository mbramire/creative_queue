class SessionsController < ApplicationController

  def new
  end

  def create
    user = CreativeUser.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      homepage = journalbooks_virtual_requests_path
      homepage = admin_dashboard_path if user.admin
      
      sign_in user
      flash[:success] = "Welcome to Creative Queue #{current_user.first_name}!"
      redirect_back_or homepage
    else
      flash[:error] = 'Invalid email/password combination'
      redirect_to root_url
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end
