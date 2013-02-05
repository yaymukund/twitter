class UsersController < ApplicationController
  before_filter :require_session, only: [:show, :edit, :update]
  before_filter :require_sessionless, only: [:new, :create]

  layout 'menuless'

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)

    if @user.save
      redirect_to edit_user_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user

    if @user.update_attributes(update_params)
      redirect_to edit_user_path, notice: 'Your settings have been updated.'
    else
      render :edit
    end
  end

  private

  def update_params
    params.require(:user).permit(:password)
  end

  def create_params
    params.require(:user).permit(:name, :password)
  end

  def require_sessionless
    if logged_in?
      redirect_to edit_user_path
    end
  end
end
