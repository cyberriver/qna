class Api::V1::AnswersController < Api::V1::BaseController
  before_action :load_answer, only: [:show]

  def index
    @answers = Answer.all
    render json: @answers, each_serializer: AnswerSerializer
  end

  def show
    render json: @answer, serializer: AnswerSerializer
  end

  private

  def load_answer
    @answer = Answer.with_attached_files.find(params[:id])    
  end
end