shared_examples 'an authed action' do
  it 'redirects the user when logged out' do
    controller.send(:reset_session)
    subject
    response.should redirect_to new_session_path
  end

  it 'does not redirect when logged in' do
    login_as(Fabricate(:user))
    subject
    response.should_not redirect_to new_session_path
  end
end
