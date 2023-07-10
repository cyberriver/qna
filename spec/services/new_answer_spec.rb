require 'rails_helper'

RSpec.describe NewAnswerService do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:subscription) { create(:subscription, question: question, user: user) }
  let(:answer) { create(:answer, question: question) }

  it 'sends notification about new answer to subscribers' do
    expect(NewAnswerMailer).to receive(:new_notification).with(subscription.user, answer).and_call_original
    subject.notify(answer)
  end
end