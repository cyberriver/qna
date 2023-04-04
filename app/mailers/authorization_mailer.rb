class AuthorizationMailer < ApplicationMailer
  def verify_email
    @authorization = Authorization.find_by(params[:id])
    @email = params[:email]
    @url = "http://localhost:3000/verify-email?uid=#{@authorization.uid}&provider=#{@authorization.provider}" #add parameter uid
    mail(to: @email, subject: "Verification email from QNA service")
  end
end
