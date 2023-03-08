require "active_support/concern"

module ResourceCommented
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_user!
    before_action :find_resource_commented, only: [:new, :create]
    before_action :choose_render_param, only: [:new, :create]
    
  end

  private

  def find_resource_commented
    @klass = params[:comment][:commentable_type].capitalize.constantize
    @klass_route = params[:comment][:commentable_type]
    puts "LOG module ResourceCommented @klass #{@klass}"
    puts "LOG module ResourceCommented @klass_route #{@klass_route}"
    puts "LOG module ResourceCommented params[:comment][:commentable_type] #{params[:comment][:commentable_type]}"
    puts "LOG module ResourceCommented params[:comment][:commentable_type] #{params[:comment][:commentable_id]}"

    @resource_commented = @klass.find(params[:comment][:commentable_id])
   
    gon.commentable_type = params[:comment][:commentable_type]
    gon.commentable_id = params[:comment][:commentable_id]
    puts "LOG gon_params module ResourceCommented: gon.commentable_type #{gon.commentable_type} gon.commentable_id #{gon.commentable_id} "
  end

  def choose_route 
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
  

  def choose_render_param 
    case @klass_route 
      when "Question"
        @channel_id = @resource_commented.id
      when "Answer"
        @channel_id = @resource_commented.question.id
      else 
      'root_path'
    end   
  end


end