require 'rails_helper'

RSpec.describe DailyDigestService do
  let!(:user1) { create(:user) }
  let!(:users) { create_list(:user, 3) }
  let!(:new_questions) { create_list(:question, 3, author: user1, created_at: 1.day.ago) }

  it 'sends daily digest to all users' do
    users.each do |user|
      expect(DailyDigestMailer).to receive(:digest).with(user, new_questions).and_call_original
    end

    subject.send_digest
  end
end
