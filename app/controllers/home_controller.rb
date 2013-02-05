class HomeController < ApplicationController
  def index
    @tweets = Tweet.order('created_at DESC').limit(10)
  end
end
