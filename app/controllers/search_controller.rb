class SearchController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def main_search

    @query = params[:query]
    search_models = []
    search_models << 'question_core' if ActiveModel::Type::Boolean.new.cast(params[:search_model_question])
    search_models << 'answer_core' if ActiveModel::Type::Boolean.new.cast(params[:search_model_answer])
    search_models << 'comment_core' if ActiveModel::Type::Boolean.new.cast(params[:search_model_comment])


    if @query.present?
      @results = ThinkingSphinx.search(@query, indices: search_models, star: true)
      render 'search/index', results: @results, query: @query
    else
      redirect_back fallback_location: root_path, notice: "Search parameters doesn't submitted"    
    end  
  end
  

  def search_questions    
    @questions = Question.search @query, :page => params[:page], :per_page => 40
    render 'questions/index', questions: @questions, query: @query
  end

end
