class CommentsController < ApplicationController

  def create
    require_login
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @comment.goal
    else
      @goal = @comment.goal
      render 'goals/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:goal_id, :content)
  end

end
