class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  authorize_resource
 
  def index
    @subscriptions = current_user.subscriptions.all
  end

  authorize_resource

  def create
    @question = Question.find(params[:question_id])
    unless Subscription.exists?(question: @question, user: current_user)
      @subscription = @question.subscriptions.create(user: current_user)
    end
  end

  def destroy
    @subscription = current_user.subscriptions.find(params[:id])
    @subscription.destroy
  end
end
