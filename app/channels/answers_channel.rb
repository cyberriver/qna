class AnswersChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "answers"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

#  def get_user_data
#    data = {
#      user: current_user.id
#      email: current_user.email
#    }
    
#  end

 
end
