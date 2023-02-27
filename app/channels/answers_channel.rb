class AnswersChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    question = Question.find(params[:id])
    stream_for question
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
 
end
