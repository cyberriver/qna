require "active_support/concern"

module ResourceLikable
  extend ActiveSupport::Concern  

  included do
    has_many :likes, dependent: :destroy, as: :likable
  end
  
    def show_rating
      likes.sum(:value)    
    end

end