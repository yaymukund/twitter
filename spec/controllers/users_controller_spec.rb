require 'spec_helper'

describe UsersController do

  def valid_attributes
    Fabricate.attributes_for(:user)
             .merge(password: 'my_password')
  end

  let(:user) { Fabricate(:user) }

  describe "GET new" do
    it "assigns a new user as @user" do
      get :new
      assigns(:user).should be_a_new(User)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new User" do
        expect {
          post :create, user: valid_attributes
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, user: valid_attributes
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, user: valid_attributes
        response.should redirect_to(edit_user_path(User.last))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved user as @user" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, user: {name: 'invalid value'}
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        User.any_instance.stub(:save).and_return(false)
        post :create, user: {name: 'invalid value'}
        response.should render_template('new')
      end
    end
  end

  describe 'GET edit' do
    subject do
      get :edit, id: user.id
      response
    end

    context 'logged in' do
      before { login_as(user) }
      it { should render_template('edit') }
    end

    it { should redirect_to new_session_path }
  end
end
