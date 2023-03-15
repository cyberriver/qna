class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show]
  before_action :gon_params_user

  private

  def log
    Rails.logger.info(request.env)
    Rails.logger.info(request.headers)
  end

  def current_user
    super
  rescue Devise::MissingWarden
    nil
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
