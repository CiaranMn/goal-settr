class GoalsController < ApplicationController

  before_action :require_login
  skip_before_action :require_login, only: [:index, :show]
  before_action :require_goal_owner, only: [:edit, :update, :destroy]

  def index
    if !params[:q]
      @goals = Goal.all
    else
      @goals = goals_sorter
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
      redirect_to @goal
    else
      render :edit
    end
  end

  def destroy
    flash[:alert] = "Goal deleted!"
    redirect_to @goal.user
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
      flash[:alert] = "You must be logged in as #{@goal.user.username} to edit this goal!"
      redirect_to @goal
    end
  end

  def goals_sorter
    case params[:q]
      when 'name'
        Goal.all.sort_by(&:name)
      when 'user'
        Goal.all.sort_by(&:user_name)
      when 'percent'
        Goal.all.sort_by(&:percentage_of_daily_goals_met).reverse
      when 'streak'
        Goal.all.sort_by(&:daily_goal_streak).reverse
      when 'due'
        Goal.all.sort_by(&:due_date)
      else
        Goal.all
    end
  end

end
