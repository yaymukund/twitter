class UsersController < ApplicationController
  before_filter :require_session, only: [:edit, :update]
  before_filter :require_sessionless, only: [:new, :create]

  layout 'menuless', only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)

    if @user.save
      flash[:notice] = 'User was successfully created.'
      redirect_to edit_user_path
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
      flash[:notice] = 'Your settings have been updated.'
      redirect_to edit_user_path
    else
      render :edit
    end
  end

  def show
    @user = User.find_by_name(params[:id])

    if @user.blank?
      not_found
    end

    @tweets = @user.tweets.order('created_at DESC').page params[:page]
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
