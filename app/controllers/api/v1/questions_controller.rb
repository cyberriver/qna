class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :load_question, only: [:show, :update, :destroy]
  authorize_resource

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
      }, status: :unprocessable_entity
    end 
  end

  def update
    question = Question.find(params[:id])
    if question.update(question_params)
      render json: question, serializer: QuestionSerializer, status: :ok
    else
      render json: question.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy
    head :no_content
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