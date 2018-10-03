class ApplicationController < ActionController::Base

  def require_login
    if !user_signed_in?
    flash[:error] = "You must be logged in to add or edit goals or comments!"
    redirect_to new_user_session_path
    end
  end

end
