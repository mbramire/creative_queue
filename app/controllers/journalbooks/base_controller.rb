class Journalbooks::BaseController < ApplicationController
  
  before_action :setup_nav_array
  before_action :signed_in_user

  layout 'journalbooks'
end
