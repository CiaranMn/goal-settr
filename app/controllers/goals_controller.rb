class GoalsController < ApplicationController

  # before_action :require_login
  # skip_before_action :require_login, only: [:index, :show]
  # before_action :require_goal_owner, only: [:edit, :update, :destroy]

  def index
    @goals = Goal.all
  end

  def show
    set_goal
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
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
    params.require(:goal).permit(:name, :description, :overall_goal, :due_date, :start_date, :daily_goal, :category_id, :user_id, :achieved)
  end

  def require_login
    if !user_signed_in?
    flash[:error] = "You must be logged in to add or edit goals!"
    redirect_to new_user_session_path
    end
  end

  def require_goal_owner
    set_goal
    if current_user != @goal.user
      flash[:alert] = "You must be logged in as #{@goal.user.username} to edit this goal!"
      redirect_to @goal
    end
  end

end
