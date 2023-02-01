class QuestionsController < ApplicationController
 
  before_action :load_question, only: [:show, :update, :destroy]

  def index
    @questions = Question.all    
  end

  def show
    @answer = @question.answers.new
    if @question.best_answer
      @best_answer = @question.best_answer
    end
		@answers = @question.answers.where.not(id: @question.best_answer_id)
    @answer.links.new

  end

  def new
    @question = current_user.questions.new
    @question.links.new
  end

  def create
    @question = current_user.questions.new(question_params) 
    if @question.save      
      redirect_to questions_path, notice: 'Your question successfully created.'
    else
      render :new
    end 
  end

  def purge
    
  end

  def update
    if  @question.author==current_user
      @question.update(question_params)
      if @question.save
        redirect_to questions_path
      else
        render :index
      end 
    else
      redirect_to questions_path, alert: "You don't have permissons."
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
    @question = Question.with_attached_files.find(params[:id])    
  end

  def question_params
    params.require(:question).permit(:title, :body, :author_id, 
                                                    files: [], links_attributes: [:name, :url] )    
  end

end
