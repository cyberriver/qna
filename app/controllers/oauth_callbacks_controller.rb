class OauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte

    # needs to refactoring method 1 - check email if it not exist then authorize by email
    # if exist then call find_for_oauth
    
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    @auth = request.env['omniauth.auth']

    authorize_by_email

    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: 'Vkontakte') if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
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

  def authorize_by_email
    if @auth[:info][:email].nil?
      @authorization = Authorization.find_by(provider: auth[:provider], uid: auth[:uid])

      if !@authorization || !@authorization.confirmed?
        @authorization = @user.create_authorization(@auth)
        render 'authorizations/email_request'
        return
      end
    end
  end


end
