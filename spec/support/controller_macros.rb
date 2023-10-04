module ControllerMacros
  def login_admin
    before(:each) do
      admin_user = create(:user, type: 'Admin')
      auth_headers = admin_user.create_new_auth_token
      request.headers.merge(auth_headers)
    end
  end

  def login_user

  end
end
