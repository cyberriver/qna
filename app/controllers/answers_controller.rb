class AnswersController < ApplicationController  
  before_action :load_answer,  only: [:edit, :update, :destroy]
  before_action :find_question, only: [:edit,:create, :update]

  def edit
    
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
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

  private

  def load_answer 
    @answer = Answer.find(params[:id])    
  end

  def find_question
    @question = Question.find_by(id: params[:question_id])
  end

  def answer_params 
    params.require(:answer).permit(:title, :question_id, :author_id)    
  end

  
end
