class AuthorizationMailer < ApplicationMailer
  def verify_email(auth, email)

    host = Rails.application.config.action_mailer.default_url_options[:host]
    port = Rails.application.config.action_mailer.default_url_options[:port]

    @confimation_link =  "http://#{host}:#{port}/authorizations/#{auth[:id]}/confirm_email" #generated confirmation link
    puts "CONFIRMATION LINK #{@confimation_link}"
    mail(to: email, 
         content_type: "text/html",
         subject: "Verification email from QNA service") do |format|
          format.html {render 'verify_email.html.slim'}
         end
  end
end
