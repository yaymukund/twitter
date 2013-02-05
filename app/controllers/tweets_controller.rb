class TweetsController < ApplicationController
  before_filter :require_session, only: [:new, :create, :destroy]
  before_filter :set_tweet, only: [:show, :edit, :update, :destroy]

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = current_user

    if @tweet.save
      flash[:notice] = 'Your tweet has been successfully published!'
      redirect_to @tweet
    else
      render :new
    end
  end

  def destroy
    flash[:alert] = 'Your tweet has been deleted.'
    redirect_to new_tweet_path
  end

  def index
    @tweets = Tweet.order('created_at DESC').limit(10)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])

    unless @tweet
      redirect_to tweets_path
    end
  end
end
