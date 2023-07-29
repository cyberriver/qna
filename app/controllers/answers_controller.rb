class AnswersController < ApplicationController  
  before_action :load_answer,  only: [:update, :destroy, :vote]
  before_action :find_question, only: [:create, :update, :purge_attachement]
  #after_action :publish_answer, only:[:create]
  helper_method :warden

  authorize_resource
  
  
  def update
      @answer.update(answer_params)
      @question = @answer.question
  end

  def create
    @answer =  @question.answers.new(answer_params)
    puts "create answers controller current user:#{current_user}"
  
    respond_to do |format|
      if @answer.save
        format.html { render partial: 'answers/answer', locals: { answer: @answer, current_user: current_user } }
        format.json { render json: @answer }
      else
        format.json do
          render json: @answer.errors.full_messages, status: 422
        end
        format.html do  
          render partial: 'shared/errors', content_type: 'text/html', 
                                           locals: { resource: @answer },
                                           formats: [:html], 
                                           status: 422
        end
      end      
    end
  end

  def destroy
      @answer.destroy
   end

  def my_answers
    @answers = current_user.answers.all
  end

  def vote
    @question = @answer.question
    @question.update(best_answer_id:@answer.id)

    if @question.reward.present?
       make_reward
    end

    @best_answer = @question.best_answer
    @answers = @question.answers.where.not(id: @question.best_answer_id)  
  end

  private

  def make_reward
    @answer.author.rewards.push(@question.reward)
  end

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id]) 
  end

  def find_question
    @question = Question.with_attached_files.find_by(id: params[:question_id])
  end

  def answer_params 
    params.require(:answer).permit(:title, :question_id, :author_id, 
                                                         files: [], 
                                                         links_attributes: [:name, :url,:_destroy]
                                                        )    
  end

  def publish_answer
    Rails.logger.debug("warden: #{warden.inspect}")
    Rails.logger.debug("warden user: #{warden.user.inspect}")
  
    return if @answer.errors.any?
    ActionCable.server.broadcast(
      "details_data_for_question_#{@question.id}", 
      { answer: render_answer, current_user_id: current_user.id }
    )    
  end

  def render_answer
    AnswersController.render(
      partial: 'answers/answer',
      locals: { 
        answer: @answer, current_user_id: @current_user.id  }
    )    
  end
  
end
