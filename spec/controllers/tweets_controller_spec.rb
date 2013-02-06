require 'spec_helper'

describe TweetsController do
  let(:user) { Fabricate(:user) }
  let(:tweet) { Fabricate(:tweet, user: user) }

  describe 'GET /tweets' do
    let(:tweets) { (1..5).map { |i| Fabricate(:tweet, created_at: i.hours.ago) }}

    subject do
      tweets # let() is lazy so we have to trigger it.
      get :index
      response
    end

    it 'displays the index with a collection of tweets' do
      subject
      response.should render_template('index')
      assigns(:tweets).should be_present
    end

    it 'orders by created_at DESC' do
      subject
      assigns(:tweets).should =~ tweets.sort_by(&:created_at).reverse
    end
  end

  describe 'GET /tweets/new' do
    subject do
      get :new
      response
    end

    it_behaves_like 'an authed action'

    before { login_as(user) }

    it 'renders a form for a new tweet' do
      subject
      response.should render_template('new')
      assigns(:tweet).should be_a_new(Tweet)
    end
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
      let(:content) { 'Too long' * 140 }

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

    before { login_as(user) }

    it 'destroys the tweet correctly' do
      expect { subject }.to change { Tweet.exists?(tweet) }.from(true).to(false)
    end

    it_behaves_like 'an authed action'
  end
end
