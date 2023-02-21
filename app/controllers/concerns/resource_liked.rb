require "active_support/concern"

module ResourceLiked
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :find_resource, only: [:like, :dislike]
  end

  private

  def find_resource
    @klass = params[:liked_type].capitalize.constantize
    @resource_liked = @klass.find(params[:id])
    @author_like = params[:liked_params][:user_id]    
  end

  def likes_params
    params.require(:liked_params).permit(:value, :user_id)    
  end

  
  
end