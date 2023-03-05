require "active_support/concern"

module ResourceCommented
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :find_resource_commented, only: [:new, :create]
  end

  private

  def find_resource_commented
    @klass = params[:comment][:commentable_type].capitalize.constantize
    @resource_commented = @klass.find(params[:comment][:commentable_id])    
  end

end