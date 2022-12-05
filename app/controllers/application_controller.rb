class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:index, :show]

  private

  def log
    Rails.logger.info(request.env)
    Rails.logger.info(request.headers)
  end
end
