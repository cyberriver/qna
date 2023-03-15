class QuestionsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "questions#index"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
