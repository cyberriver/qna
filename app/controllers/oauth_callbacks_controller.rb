class OauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte

    @auth = request.env['omniauth.auth']
    @auth[:info][:email] = ''
    
    # case when email is exists
    if @auth[:info][:email] != '' || @auth[:info][:email].present?
      @user = User.find_for_oauth(request.env['omniauth.auth'])
      redirect_after_authorization(@user)

    else # if email does't recieved

      @authorization = Authorization.find_by(provider: @auth[:provider], uid: @auth[:uid])

      #user is nil, needs to find User

      render 'authorizations/email_request'


      #if @authorization.nil?
      #  @authorization = @user.create_authorization(@auth)
     # end
    end    
  end

  def github
    @user = User.find_for_oauth(request.env['omniauth.auth'])

    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end

  private

  def redirect_after_authorization(user)
    if user&.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Vkontakte') if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end

 
end
