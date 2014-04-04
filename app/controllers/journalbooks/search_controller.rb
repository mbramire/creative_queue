class Journalbooks::SearchController < Journalbooks::BaseController

  def new 
    @search = Search.new
  end

  def show 
    @search = Search.begin_search(params[:search])
  end

  private

    def safe_params
      params.require(:search).permit!
    end

    def setup_nav_array
      @nav = ['search']
    end
end