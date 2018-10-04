class BoostsController < ApplicationController

  def create
    require_login
    @boost = Boost.new(boost_params)
    @boost.user = current_user
    if @boost.save
      redirect_to @boost.goal
    else
      @goal = @boost.goal
      render 'goals/show'
    end
  end

  private

  def boost_params
    params.require(:boost).permit(:goal_id, :boost_type)
  end

end
