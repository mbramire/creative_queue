class Admin::BaseController < ApplicationController
  
  before_action :signed_in_user
  before_action :admin_user
  before_action :setup_nav_array
  
  layout 'admin'
end
