require "active_support/concern"

module ResourceCommented
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :find_resource, only: [:new, :create]
  end

  private

  def find_resource
    @klass = params[:commented_resource].capitalize.constantize
    @resource_commented = @klass.find(params[:id])    
  end


end