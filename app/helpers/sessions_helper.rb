module SessionsHelper

  def sign_in(user)
    remember_token = CreativeUser.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, CreativeUser.encrypt(remember_token))
    self.current_user = user
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    remember_token  = CreativeUser.encrypt(cookies[:remember_token])
    @current_user ||= CreativeUser.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      flash[:error] = "Please sign in."
      redirect_to root_path
    end
  end

  def admin_user
    unless current_user.admin
      flash[:error] = "Requires admin privledges."
      redirect_to root_path
    end
  end

  def journalbooks_user
    unless current_user.journalbooks
      flash[:error] = "Requires Journalbooks privledges."
      redirect_to root_path
    end
  end

  def admin_or_current_user(virtual_request)
    request = VirtualRequest.find(virtual_request)
    unless current_user.admin || current_user.owns?(request)
      store_location
      flash[:error] = "Requires admin privledges or ownership of virtual request."
      redirect_to root_path
    end
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def send_home(user)
    homepage = journalbooks_virtual_requests_path if user.journalbooks
    homepage ||= admin_dashboard_path if user.admin
    homepage ||= root_path

    redirect_to homepage
  end

  def store_location
    session[:return_to] = request.url
  end
end