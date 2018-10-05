class GoalsController < ApplicationController

  before_action :require_login
  skip_before_action :require_login, only: [:index, :show]
  before_action :require_goal_owner, only: [:edit, :update, :confirm_delete, :destroy, :calendar, :calendar_update]

  def index
    if !params[:q]
      @goals = Goal.all
      @sort = "All goals"
    else
      @goals, @sort = goals_sorter
    end
  end

  def show
    set_goal
    @boost = Boost.new
    @comment = Comment.new
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user = current_user
    if @goal.save
      flash[:alert] = "Goal created!"
      redirect_to @goal
    else
      render :new
    end
  end

  def edit
    if current_user != @goal.user
      flash[:alert] = "You must be logged in as #{@goal.user.username} to edit this goal!"
      redirect_to @goal
    end
  end

  def update
    if @goal.update(goal_params)
      flash[:alert] = "Goal updated!"
      redirect_to @goal
    else
      render :edit
    end
  end

  def calendar
    if params[:date]
      date = Date.parse(params[:date])
    else
      date = Date.today
    end
    @calendar = Calendar.new(date)
  end

  def calendar_update
    # first we destroy all existing DGM records for the month in question, in case some have been de-selected, using a class method in the model
    DailyGoalMet.delete_all_from_month(@goal, params[:goal][:month])
    # then we iterate over the array and create DGMs dates which have been selected - if any
    selections = params[:goal][:daily_goal_mets]
    if selections
      selections.each do |date|
        if date != ""
          DailyGoalMet.create(goal_id: @goal.id, date: date)
        end
      end
    end
    flash[:alert] = "Progress recorded - keep it up!"
    redirect_to @goal
  end

  def confirm_delete
  end

  def destroy
    if request.referrer.include? "goals/#{@goal.id}/delete"
      @goal.destroy
      flash[:alert] = "Goal deleted!"
      redirect_to @goal.user
    else
      flash[:alert] = "Please go through the confirmation page to delete goals."
      redirect_to @goal
    end
  end

  private

  def set_goal
    @goal = Goal.find(params[:id])
  end

  def goal_params
    params.require(:goal).permit(:name, :description, :overall_goal, :due_date, :start_date, :daily_goal, :category_id, :achieved)
  end

  def require_goal_owner
    set_goal
    if current_user != @goal.user
      flash[:alert] = "You must be logged in as #{@goal.user.name} to edit this goal!"
      redirect_to @goal
    end
  end

  def goals_sorter
    case params[:q]
      when 'name'
        [Goal.order(:name), "All goals (by name)"]
      when 'user'
        [Goal.all.sort_by(&:user_name), "All goals (by user)"]
      when 'daily'
        [Goal.all.sort_by(&:percentage_of_daily_goals_met).reverse, "All goals (by % daily goals met)"]
      when 'streak'
        [Goal.all.sort_by(&:daily_goal_streak).reverse, "All goals (by current streak)"]
      when 'due'
        [Goal.order(:due_date), "All goals (by due date)"]
      when 'active'
        [Goal.active_goals, "Active goals only"]
      when 'achieved'
        [Goal.goals_achieved, "Achieved goals only"]
      when 'due_soon'
        [Goal.goals_due_soon, "Goals due within 10 days"]
      else
        [Goal.all, "All goals"]
    end
  end

end
