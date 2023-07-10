class NewAnswerMailer < ApplicationMailer

  def new_notification(user, answer)
    @greeting = user.email.split('@').first
    @question_title = answer.question.title
    @answer_body = answer.body

    mail to: user.email
  end
end