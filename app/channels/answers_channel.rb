class AnswersChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    question = Question.find(params[:id])
    stream_from "details_data_for_question_#{question.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
 
end
