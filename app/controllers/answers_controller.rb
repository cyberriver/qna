class AnswersController < ApplicationController  
  before_action :load_answer,  only: [:update, :destroy, :vote]
  before_action :find_question, only: [:create, :update, :purge_attachement]
  
  def update
    if @answer.author==current_user
      @answer.update(answer_params)
      @question = @answer.question
    else
      redirect_to question_path(@answer.question), alert: "You don't have permissons."
      
    end   
  end

  def create
    @answer =  @question.answers.create(answer_params)
  end

  def destroy
    if  @answer.author==current_user 
      @answer.destroy
    else
      redirect_to question_path(@answer.question), alert: "You don't have permissons."
    end 
  end

  def my_answers
    @answers = current_user.answers.all
  end

  def vote
    @question = @answer.question
    @question.update(best_answer_id:@answer.id)
    @best_answer = @question.best_answer
    @answers = @question.answers.where.not(id: @question.best_answer_id)  
  end

  private

  def load_answer
     @answer = Answer.with_attached_files.find(params[:id]) 
  end

  def find_question
    @question = Question.with_attached_files.find_by(id: params[:question_id])
  end

  def answer_params 
    params.require(:answer).permit(:title, :question_id, :author_id, 
                                                         files: [], links_attributes: [:name, :url])    
  end

  
end
