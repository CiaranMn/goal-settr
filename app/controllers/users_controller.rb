class UsersController < ApplicationController

  before_action :authenticate_user!, except:[:show, :index]
  helper_method :resource_name, :resource, :devise_mapping, :resource_class

  def index
   @users = User.all
   # byebug
   @latest_users = @users.select {|user| !user.goals.empty? }.sort_by {|u| u.created_at}[0..10].reverse
  end

  def show
    @user = User.find(params[:id])
    @goals = @user.goals
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    unless @user == current_user
        flash[:alert] = "Access denied."
      redirect_to @user
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name)
  end


end
