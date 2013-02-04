class TweetsController < ApplicationController
  before_filter :require_session, only: [:new, :create, :destroy]

  def new
  end

  def create
    redirect_to :show
  end

  def destroy
  end
end
