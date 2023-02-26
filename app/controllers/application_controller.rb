class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show]

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
end
