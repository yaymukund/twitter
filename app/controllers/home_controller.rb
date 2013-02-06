class HomeController < ApplicationController
  def index
    @tweets = Tweet.order('created_at DESC').page params[:page]

    if logged_in?
      @mentions = current_user.received_tweets.order('created_at DESC').limit(5)
    end
  end
end
