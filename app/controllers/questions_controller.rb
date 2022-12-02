class QuestionsController < ApplicationController
  before_action :load_question, only: [:show, :edit, :update, :destroy]
  before_action :find_test, only: [:new,:create]

  def index
    @questions = Question.all    
  end

  def show
  
  end

  def new
    @question = @test.questions.new    
  end

  def edit  
    
  end

  def create
    @question = @test.questions.new(question_params) 
    if @question.save
      redirect_to @question
    else
      render :new
    end 
  end

  def update
    @question.update(question_params)
    if @question.save
      redirect_to @question
    else
      render :edit
    end 
  end

  def destroy
    @question.destroy
    redirect_to questions_path(@question.test)    
  end

  private 

  def load_question
    @question = Question.find(params[:id])
    
  end

  def question_params
    params.require(:question).permit(:title, :body, :test_id)    
  end

  def find_test 
    @test = Test.find_by(id: params[:test_id])

  end

end
