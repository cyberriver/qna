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

  private
  
  def render_new_like
    respond_to do |format|
      if @like.save
        format.json { render json: {
                        rating: @resource_liked.show_rating, 
                        resource_id: @resource_liked.id
                        } 
                      }
      else
        format.json do
          render json: @resource_liked.errors.full_messages, status: 422
        end        
      end      
    end
  end

  def render_update_like
    respond_to do |format|
      if @like.update(likes_params)
        format.json { render json: {
                        rating: @resource_liked.show_rating, 
                        resource_id: @resource_liked.id
                        } 
                      }
      else
        format.json do
          render json: @resource_liked.errors.full_messages, status: 422
        end        
      end      
    end
  end
  
end