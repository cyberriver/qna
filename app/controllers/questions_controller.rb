class QuestionsController < ApplicationController
 
  before_action :load_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question.all    
  end

  def show
    @answer = @question.answers.new
    if @question.best_answer
      @best_answer = @question.best_answer
    end
		@answers = @question.answers.where.not(id: @question.best_answer_id)

  end

  def new
    @question = current_user.questions.new    
  end

  def edit  
    if  @question.author==current_user
      render :edit
    else
      redirect_to questions_path, alert: "You don't have permissons."
    end
  end

  def create
    @question = current_user.questions.new(question_params) 
    if @question.save      
      redirect_to questions_path, notice: 'Your question successfully created.'
    else
      render :new
    end 
  end

  def update    
    @question.update(question_params)
    if @question.save
      redirect_to questions_path
    else
      render :edit
    end 
  end

  def destroy
    if  @question.author==current_user 
      @question.destroy
      redirect_to questions_path, notice: 'Your question successfully deleted.'
    else
      redirect_to questions_path, alert: "You don't have permissons."
    end   
  end

  private 

  def load_question
    @question = Question.find(params[:id])    
  end

  def question_params
    params.require(:question).permit(:title, :body, :author_id, :file)    
  end

end
