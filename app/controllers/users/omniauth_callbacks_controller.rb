class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def vkontakte
    render json: request.env['omniauth.auth']
  end

  def github
  end
end
