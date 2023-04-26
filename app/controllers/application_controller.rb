class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show]
  before_action :gon_params_user
  

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to  root_url, alert: exception.message  
  end

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

end
