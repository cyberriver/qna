class NewAnswerNotifyJob < ApplicationJob
  queue_as :default

  def perform(answer)
    NewAnswerService.new.notify(answer)
  end
end