require 'rails_helper'

RSpec.describe DailyDigestService do
  let!(:users) { create_list(:user, 3, email: "user@test.com") }
  let(:questions) { create_list(:question, 3) }

  it 'sends daily digest to all users' do
    new_questions = Question.where(created_at: Date.yesterday.all_day).to_a

    users.each { |user| expect(DailyDigestMailer).to receive(:digest).with(user, new_questions).and_call_original }
    subject.send_digest
  end

end
