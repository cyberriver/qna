class AnswersController < ApplicationController  
  before_action :load_answer,  only: [:show, :edit, :update, :destroy]
  before_action :find_question, only: [:new, :create]

  def index 
   @answers = Answer.all    
  end

  def show    
  end

  def new          
    @answer = @question.answers.new
  end

  def edit
    
  end

  def update
    @answer.update(answer_params)

    if @answer.save
      redirect_to question_answers_path(@answer.question), status: 300
    else
      render :edit
    end
    
  end

  def create
    @answer =  @question.answers.new(answer_params)
    if @answer.save
      redirect_to question_answers_path(@answer.question), status: 300
    else
      render :new
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_answers_path(@answer.question)

  end

  def my_answers
    @answers = current_user.author_answers.all
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
