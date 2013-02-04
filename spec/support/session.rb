def login_as(user)
  session[:current_user_id] = user.id
end

def current_user
  controller.send(:current_user)
end
