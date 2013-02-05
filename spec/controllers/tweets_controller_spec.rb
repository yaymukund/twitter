require 'spec_helper'

describe TweetsController do
  let(:user) { Fabricate(:user) }
  let(:tweet) { Fabricate(:tweet, user: user) }

  describe 'GET /tweets' do
    before { 5.times { Fabricate(:tweet) } }

    subject do
      get :index
      response
    end

    it 'displays the index with a collection of tweets' do
      subject
      response.should render_template('index')
      assigns(:tweets).should be_present
    end
  end

  describe 'GET /tweets/new' do
    subject do
      get :new
      response
    end

    it_behaves_like 'an authed action'

    before { login_as(user) }

    it { should render_template('new') }
  end

  describe 'POST /tweets' do
    let(:content) { 'My day went well!' }

    subject do
      post :create, tweet: {content: content}
      response
    end

    before { login_as(user) }

    it 'creates a tweet' do
      expect { subject }.to change { Tweet.count }.by(1)
    end

    it 'redirects to the new tweet' do
      subject
      response.should redirect_to tweet_path(Tweet.last)
    end

    context 'with invalid attributes' do
      let(:content) { 'Too long' * 160 }

      it 'does not create the tweet' do
        expect { subject }.to_not change { Tweet.count }
      end
    end

    it_behaves_like 'an authed action'
  end

  describe 'GET /tweets/:id' do
    subject do
      get :show, id: tweet
      response
    end

    it 'renders the correct tweet' do
      subject
      response.should render_template(tweet)
      assigns(:tweet).should == tweet
    end
  end

  describe 'DELETE /tweets/:id' do
    subject do
      delete :destroy, id: tweet
      response
    end

    it_behaves_like 'an authed action'
  end
end
