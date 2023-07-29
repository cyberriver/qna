class AnswersChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    question = Question.find(params[:id])
    stream_from "details_data_for_question_#{question.id}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  
  def receive(data)
    current_user = User.find(data['current_user_id'])
    # Теперь у вас есть текущий пользователь для этого подключения
  end
 
end
