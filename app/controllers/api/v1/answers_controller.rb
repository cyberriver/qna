class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_question, only: [:create]
  before_action :load_answer, only: [:show]

  def index
    @answers = Answer.all
    render json: @answers, each_serializer: AnswerSerializer
  end

  def show
    render json: @answer, serializer: AnswerSerializer
  end

  def create
    @answer =  @question.answers.new(answer_params)
    if @answer.save           
      render json: @answer, serializer: AnswerSerializer
    else
      render json: {
        errors: @answer.errors.full_messages
      }, status: :unprocessable_entity
    end 
  end

  private

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])    
  end

  def answer_params
    params.require(:answer).permit(:title, :author_id, 
                                                    files: [], 
                                                    links_attributes: [:name, :url])    
  end

  
  def load_question
    @question = Question.with_attached_files.find(params[:question_id])    
  end

  def question_params
    params.require(:question).permit(:title, :body, :author_id, 
                                                    files: [], 
                                                    links_attributes: [:name, :url],
                                                    reward_attributes: [:title, :file])    
  end


end