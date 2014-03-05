class Journalbooks::SearchController < Journalbooks::BaseController

  def index 
    @virtual_requests = params[:search].nil? ? "" : VirtualRequest.search(params) 
  end

  private

    def setup_nav_array
      @nav = ['search']
    end
end