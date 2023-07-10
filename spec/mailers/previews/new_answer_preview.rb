class NewAnswerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/new_answer/new_notification
  def new_notification
    NewAnswerMailer.new_notification
  end

end