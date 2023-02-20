require "active_support/concern"

module ResourceLiked
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :find_resource, only: [:like, :dislike]
  end

  def like
    @like = @resource_liked.likes.new(likes_params)
    @like.save   
  end

  def dislike
    @resource_liked
  end

  private

  def find_resource
    @klass = params[:liked_type].capitalize.constantize
    @resource_liked = @klass.find(params[:id])    
  end

  def likes_params
    params.require(:liked_params).permit(:value, :user_id)
    
  end
  
end