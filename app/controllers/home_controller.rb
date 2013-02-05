class HomeController < ApplicationController
  def index
    @tweets = Tweet.last(10)
  end
end
