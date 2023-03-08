class CommentsChannel < ApplicationCable::Channel
    def subscribed
        stream_from "comments_for_question_#{params[:id]}"
    end
    
    def unsubscribed
      # Any cleanup needed when channel is unsubscribed
    end

        
end