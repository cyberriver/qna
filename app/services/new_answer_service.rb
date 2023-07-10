class NewAnswerService
  def notify(answer)
    subscriptions = Subscription.where(question: answer.question)

    subscriptions.find_each(batch_size: 500) do |subscription|
      NewAnswerMailer.new_notification(subscription.user, answer).deliver_later
    end
  end
end