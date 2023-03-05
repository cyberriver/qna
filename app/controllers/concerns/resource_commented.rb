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
    @klass_route = params[:comment][:commentable_type]
    @resource_commented = @klass.find(params[:comment][:commentable_id])    
  end

  def choose_route
    puts "LOGGG params[:comment][:commentable_type] #{params[:comment][:commentable_type]}"
    case @klass_route 
      when "Question"
        'questions_path'
      when "Answer"
        "question_path(#{get_params_for_route})"
      else 
        'root_path'
    end   
  end

  def get_params_for_route
    @resource_commented.question.id if @klass_route == "Answer"
  end


end