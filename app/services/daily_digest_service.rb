class DailyDigestService
  def send_digest
    questions = Question.where(created_at: Date.yesterday.all_day).to_a
    User.find_each(batch_size: 500) do |user|
      DailyDigestMailer.digest(user, questions).deliver_later
    end    
  end
end