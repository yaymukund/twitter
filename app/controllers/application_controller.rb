class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  # Sessions

  def logged_in?
    session[:current_user_id].present?
  end

  def current_user
    if session[:current_user_id]
      User.find(session[:current_user_id])
    else
      nil
    end
  end

  def require_session
    unless logged_in?
      redirect_to new_session_path
    end
  end
end
