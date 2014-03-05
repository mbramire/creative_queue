class Journalbooks::RulesController < Journalbooks::BaseController

  def index 
    @rules = Rule.all
  end

  def new
    @rule = Rule.new
  end

  def show
    @rule = Rule.find(params[:id])
  end

  def edit
    @rule = Rule.find(params[:id])
  end

  def create
    @rule = Rule.new(rule_params)
    if @rule.save
      flash[:success] = "New rule has been created."
      redirect_to journalbooks_rules_path
    else
      render 'new'
    end
  end

  def update
    @rule = Rule.find(params[:id])
    if @rule.update_attributes(rule_params)
      flash[:success] = "Rule updated."
      redirect_to journalbooks_rules_path
    else
      render 'edit'
    end
  end

  def destroy
    @rule = Rule.find(params[:id])
    @rule.destroy
    flash[:success] = "Rule removed."
    redirect_to journalbooks_rules_path
  end

  private
    def rule_params
      params.require(:rule).permit!
    end

    def setup_nav_array
      @nav = ['rules']
    end
end
