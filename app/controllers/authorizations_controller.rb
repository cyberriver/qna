class AuthorizationsController < ApplicationController
  skip_before_action :authenticate_user!

  def send_email
    puts "STARTED processing method send_email"
    @email = authorization_params[:email]
    @user = User.find_by(email: @email)
   

    if @user.nil?
      @password = Devise.friendly_token[0, 20]
      @user = User.create!(email: @email, password: @password, password_confirmation: @password)
    end

    @authorization = find_authorization
    @authorization ||= create_user_authorization(@user)

    puts "Starting delivering email"
    AuthorizationMailer.verify_email(@authorization, @email).deliver_now
    puts "email delivered"
  end

  def confirm_email
    @auth = Authorization.find(params[:id])
    @auth.confirmed = true
    @auth.save!

    sign_in_and_redirect @auth.user, event: :authentication
  end

  private

  def authorization_params
    params.require(:authorization).permit(:email, :provider, :uid, :id)
  end

  def find_authorization
    Authorization.find_by(provider: authorization_params[:provider], uid: authorization_params[:uid])
  end

  def create_user_authorization(user)
    user.authorizations.create(provider: authorization_params[:provider],
                               uid: authorization_params[:uid],
                               confirmed: false)
  end
end
