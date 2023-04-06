class OauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    @auth = request.env['omniauth.auth']    
    authorize(@auth,'vkontakte') 
  end

  def github
    @auth = request.env['omniauth.auth']    
    authorize(@auth,'Github') 
   
    
  end

  private

  def check_email(auth)
    if auth[:info] != ''
      if auth[:info][:email].present?
      end
    end
  end

  def check_authorization(auth)
    @authorization = Authorization.find_by(provider: auth[:provider], uid: auth[:uid])
    
    if @authorization.nil?
      @authorization = Authorization.create(provider: auth[:provider], uid: auth[:uid])
    end
  end

  def authorize(auth, provider)
    check_authorization(auth)
    if check_email(auth) || @authorization.confirmed?
      @user = User.find_for_oauth(request.env['omniauth.auth'])
      redirect_after_authorization(@user, provider)

    else # if email does't recieved
      render 'authorizations/email_request'      
    end    
  end



  def redirect_after_authorization(user, provider)
    if user&.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    else
      redirect_to root_path, alert: 'Something went wrong'
    end
  end

 
end
