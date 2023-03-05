require "active_support/concern"

module ResourceCommented
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :find_resource_commented, only: [:new, :create]
  end

  private

  def find_resource_commented
    @klass = params[:comment][:commentable_type].capitalize.constantize
    @resource_commented = @klass.find(params[:comment][:commentable_id])    
  end

  def choose_route
    case params[:comment][:commentable_type]
      when 'question' then 'questions_path'
      when 'answer' then 'question_answers_path'
      else 'questions_path'
    end   
  end

end