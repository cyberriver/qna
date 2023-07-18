class SearchController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def main_search
    search_models = []
    search_models << Question if params[:search_model_question].present?
    search_models << Answer if params[:search_model_answer].present?
    if query.present?
      @results = ThinkingSphinx.search(query, search_models)
      render 'search/index', results: @results, query: query
    else
      redirect_back fallback_location: root_path, notice: "file deleted success"    
    end  
  end
  

  def search_questions    
    @questions = Question.search query, :page => params[:page], :per_page => 40
    render 'questions/index', questions: @questions, query: query
  end

  private

  def query
    params[:query]
  end
end
