require 'spec_helper'

describe UsersController do

  let(:user) { Fabricate(:user) }

  describe 'POST /user' do
    subject do
      post :create, user: {name: name, password: password}
      response
    end

    let(:valid_attributes) { Fabricate.attributes_for(:user) }
    let(:name) { valid_attributes[:name] }
    let(:password) { valid_attributes[:password] }

    it 'creates the user' do
      expect { subject }.to change { User.count }.by(1)
    end

    it { should redirect_to edit_user_path }

    context 'with invalid attributes' do
      let(:name) { 'invalid name@&$' }

      it 'doesn\'t create the user' do
        expect { subject }.to_not change { User.count }
      end
    end
  end

  describe 'GET /user/new' do
    subject do
      get :new
      response
    end

    it { should render_template('new') }
  end

  describe 'GET /user/:id' do
    subject do
      get :show, id: user.name
      response
    end

    let(:tweets) { (1..5).map { Fabricate(:tweet, user: user) }}

    it 'displays the last n tweets' do
      tweets # Force the lazy block to run and fabricate tweets.
      subject
      assigns(:tweets).should include(*tweets)
      response.should render_template('show')
    end
  end

  describe 'GET /user/edit' do
    before { login_as(user) }

    subject do
      get :edit
      response
    end

    it_behaves_like 'an authed action'

    it 'renders the edit form for the current user' do
      subject
      response.should render_template('edit')
      assigns(:user).should == user
    end
  end

  describe 'PUT /user' do
    let(:password) { 'newpass' }

    before { login_as(user) }

    subject do
      put :update, user: {password: password}
      response
    end

    it_behaves_like 'an authed action'

    it 'redirects to the edit form' do
      subject
      response.should redirect_to edit_user_path
    end

    it 'updates the attributes' do
      expect { subject }.to change { user.reload.password_digest }
    end

    it 'lets the user authenticate with the new password' do
      subject
      User.authenticate(user.name, password).should == user
    end

    context 'with invalid attributes' do
      let(:password) { '' }

      it 'rerenders the edit form with errors' do
        subject
        response.should render_template('edit')
        assigns(:user).should_not be_valid
      end
    end
  end
end
