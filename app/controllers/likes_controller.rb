class LikesController < ApplicationController
  
  include ResourceLiked

  def like
    @like = @resource_liked.likes.new(likes_params)
    
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

  def dislike
    @like = @resource_liked.likes.where("user_id = #{@author_like}")
    @like.update(likes_params)   

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