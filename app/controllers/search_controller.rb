class SearchController < ApplicationController
  skip_authorization_check
  skip_before_action :authenticate_user!

  def search_questions    
    @questions = Question.search search_options
    render 'questions/index', questions: @questions, query: @query
  end

  private

  def search_options
    @search_options = params[:query]
  end  
end
