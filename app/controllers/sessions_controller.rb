class SessionsController < ApplicationController
  def create
    if logged_in?
      destroy
      return
    end

    user = User.authenticate(*session_params.values_at(:name, :password))

    if user.present?
      session[:current_user_id] = user.id
      redirect_to root_path
    else
      render :new, locals: {notice: 'Wrong username/password combination.'}
    end
  end

  def destroy
    reset_session
    redirect_to new_session_path
  end

  private

  def session_params
    params.permit(:name, :password)
  end
end
