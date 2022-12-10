module ControllerHelpers
  def login(user)
    get new_user_session_path
    @request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in(user)
  end
end