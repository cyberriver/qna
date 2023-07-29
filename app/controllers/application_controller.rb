class ApplicationController < ActionController::Base
  
  before_action :authenticate_user!
  before_action :gon_params_user
  

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to  root_url, alert: exception.message  
  end

  check_authorization unless: :devise_controller?

  private

  def log_request
    Rails.logger.info(request.env)
    Rails.logger.info(request.headers)
  end

  
  def gon_params_user
    gon.controller_name = params[:controller]
    gon.controller_action = params[:action]
    gon.params_id = params[:id]
  
    if current_user.present?
      gon.current_user_id = current_user.id
    end
  end

  def current_user
    puts "LOGG!! current user method launch"
    Rails.logger.debug("warden: #{warden}")
    Rails.logger.debug("warden user: #{warden.user}")
    @current_user = warden.user
    @current_user
  end

  def warden
    request.env['warden']
  end
  
end
