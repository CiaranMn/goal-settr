class UsersController < ApplicationController

  def show
    @user = User.find(1)
    @goals = @user.goals
  end

end
