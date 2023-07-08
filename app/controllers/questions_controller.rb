class QuestionsController < ApplicationController 
  before_action :load_question, only: [:show, :update, :destroy]
  after_action :publish_question, only: [:create]
  before_action :load_subscription, only: :show

  authorize_resource

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
    @question.reward = Reward.new
    
  end

  def create
    @question = current_user.questions.new(question_params)    
    if @question.save
      @question.subscriptions.create(user: current_user)      
      redirect_to questions_path, notice: 'Your question successfully created.'
    else
      render :new
    end 
  end

  def purge
    
  end

  def update
    @question.update(question_params)
      if @question.save
        redirect_to questions_path
      else
        render :index
      end 
 
  end     


 def destroy
    @question.destroy
    redirect_to questions_path, notice: 'Your question successfully deleted.'
  end 

  private 

  def load_question
    @question = Question.with_attached_files.find(params[:id])    
  end

  def load_subscription
    @subscription = @question.subscriptions.where(user: current_user).first
  end

  def load_questions
    @questions = Question.all
  end

  def question_params
    params.require(:question).permit(:title, :body, :author_id, 
                                                    files: [], 
                                                    links_attributes: [:name, :url],
                                                    reward_attributes: [:title, :file])    
  end

  def publish_question
    return if @question.errors.any?
    ActionCable.server.broadcast(
      "questions#index", 
      question: render_question     
    )    
  end

  def render_question 
    QuestionsController.render(
      partial: 'questions/question',
      locals: { 
        question: @question }
    )    
  end

end
