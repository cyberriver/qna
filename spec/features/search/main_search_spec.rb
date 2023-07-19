require 'rails_helper'
require 'sphinx_helper'

RSpec.feature 'User can find question using search', %q{
  In order to get information about quesiton
  user can promt data into search and receive proper question. 
  Search should support search by title and question's body
} do
  given!(:user) { create(:user) }
  given!(:questions) {create_list(:question, 3, author: user)}
  given!(:answer) {create(:answer, question: questions.first, author: user)}
 # perform_enqueued_jobs { your_action_that_triggers_reputation_job }

  scenario 'unauthenticated user find question by title' do
    visit questions_path
    within '.main-search' do
      check 'search_model_question'
      uncheck 'search_model_answer'

      fill_in 'query', with: 'Question 2'

      ThinkingSphinx::Test.run do
         Question.search 'Question 2'    
      end  
    end
    #expect(page).to have_current_path(search_questions_path)
    expect(page).to have_content 'Question 2'
    expect(find_field('search_model_question')).to be_checked
    expect(find_field('search_model_answer')).not_to be_checked
  end 

  scenario 'unauthenticated user find answer by title' do
    visit questions_path
    within '.main-search' do
      uncheck 'search_model_question'
      check 'search_model_answer'

      fill_in 'query', with: 'Answer 1'

      ThinkingSphinx::Test.run do
         Question.search 'Answer 1'    
      end  
    end
    #expect(page).to have_current_path(search_questions_path)
    expect(page).to have_content 'Answer 1'
    expect(find_field('search_model_answer')).to be_checked
    expect(find_field('search_model_question')).not_to be_checked
  end 

end