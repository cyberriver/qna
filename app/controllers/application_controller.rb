class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show]
  before_action :gon_params

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

  def gon_params
    gon.params_id = params[:id]
    gon.current_user_id = current_user.id
  end

end
