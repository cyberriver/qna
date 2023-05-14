class Api::V1::QuestionsController < Api::V1::BaseController
  before_action :load_question, only: [:show]

  def index
    @questions = Question.all
    render json: @questions, each_serializer: QuestionSerializer
  end

  def show
    render json: @question, serializer: QuestionSerializer
  end

  private

  def load_question
    @question = Question.with_attached_files.find(params[:id])    
  end
end