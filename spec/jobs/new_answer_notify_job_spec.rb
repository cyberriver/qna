require 'rails_helper'

RSpec.describe NewAnswerNotifyJob, type: :job do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question) }
  let(:service) { double('NewAnswerService') }

  before do
    allow(NewAnswerService).to receive(:new).and_return(service)
  end

  it 'calls NewAnswerService#notify' do
    expect(service).to receive(:notify).with(answer)
    NewAnswerNotifyJob.perform_now(answer)
  end
end
