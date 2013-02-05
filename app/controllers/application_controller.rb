class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  # Sessions

  def logged_in?
    session[:current_user_id].present?
  end

  helper_method :logged_in?

  def current_user
    if session[:current_user_id]
      User.find(session[:current_user_id])
    else
      nil
    end
  end

  helper_method :current_user

  def require_session
    unless logged_in?
      redirect_to new_session_path
    end
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
