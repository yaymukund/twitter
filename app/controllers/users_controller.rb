class UsersController < ApplicationController
  before_filter :require_session, only: [:show, :edit]

  # GET /users/new
  # GET /users/new.json
  def new
    if logged_in?

    end
    @user = User.new
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to edit_user_path(@user), notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def edit
    unless logged_in?
      redirect_to new_session_path
    end

    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :password)
  end
end
