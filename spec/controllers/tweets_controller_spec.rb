require 'spec_helper'

describe TweetsController do
  let(:user) { Fabricate(:user) }
  let(:tweet) { Fabricate(:tweet, user: user) }

  describe 'GET /tweets' do
    # TODO
  end

  describe 'GET /tweets/new' do
    subject do
      get :new
      response
    end

    it_behaves_like 'an authed action'
  end

  describe 'POST /tweets' do
    subject do
      post :create, tweet: {
        content: 'My day was fine.',
        user: user
      }

      response
    end

    it_behaves_like 'an authed action'
  end

  describe 'GET /tweets/:id' do
    # TODO
  end

  describe 'DELETE /tweets/:id' do
    subject do
      delete :destroy, id: tweet
      response
    end

    it_behaves_like 'an authed action'
  end
end
