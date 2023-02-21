require "active_support/concern"

module ResourceLikable
  extend ActiveSupport::Concern  

  included do
    has_many :likes, dependent: :destroy, as: :likable
  end
  
    def show_rating
      likes.sum(:value)    
    end
  
    def count_likes
      likes.where(value: 1).count
    end
  
    def count_dislikes
      likes.where(value: -1).count
    end

    def is_liked?(resource)
    
    end 
  
end