class SessionsController < ApplicationController
  layout 'menuless'

  def create
    if logged_in?
      destroy
      return
    end

    user = User.authenticate(*session_params.values_at(:name, :password))

    if user.present?
      session[:current_user_id] = user.id
      flash[:notice] = "Welcome back, #{user.name}"
      redirect_to root_path

    else
      flash[:alert] = 'Wrong username/password combination.'
      render :new
    end
  end

  def destroy
    reset_session
    flash[:notice] = 'You have been logged out successfully.'
    redirect_to new_session_path
  end

  private

  def session_params
    params.permit(:name, :password)
  end
end
