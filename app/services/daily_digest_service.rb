class DailyDigestService
  def send_digest
    User.find_each(batch_size: 500) do |user|
      DailyDigestMailer.digest(user)
    end    
  end
end