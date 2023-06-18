class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :load_question, only: [:show]

  def index
    @questions = Question.all
    render json: @questions, each_serializer: QuestionSerializer
  end

  def show
    render json: @question, serializer: QuestionSerializer
  end

  def create
    @question = User.find_by(id: question_params[:author_id]).questions.new(question_params)
    if @question.save           
      render json: @question, serializer: QuestionSerializer
    else
      render json: {
        errors: @question.errors.full_messages
      }, status: 400
    end 
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])    
  end

  def question_params
    params.require(:question).permit(:title, :body, :author_id, 
                                                    files: [], 
                                                    links_attributes: [:name, :url],
                                                    reward_attributes: [:title, :file])    
  end

end