require 'spec_helper'

describe SessionsController do

  let(:user) { Fabricate(:user) }

  describe 'GET new' do
    it 'returns http success' do
      get 'new'
      response.should be_success
    end
  end

  describe 'POST create' do
    subject do
      post :create, name: name,
                    password: password
      response
    end

    context 'with valid username and password' do
      let(:name) { user.name }
      let(:password) { user.password }

      it 'succeeds and logs in the user' do
        subject.should redirect_to root_path
        current_user.should == user
      end
    end

    context 'with invalid username and password' do
      let(:name) { 'nonsenseuser' }
      let(:password) { 'nonsense' }

      it 'fails and rerenders the login form' do
        subject.should render_template('new')
        current_user.should be_blank
      end
    end
  end

  describe 'DELETE destroy' do
    before { login_as(user) }

    it 'logs out successfully' do
      delete :destroy
      current_user.should be_blank
      response.should redirect_to new_session_path
    end
  end
end
