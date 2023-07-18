require 'rails_helper'
require 'sphinx_helper'

RSpec.feature 'User can find question using search', %q{
  In order to get information about quesiton
  user can promt data into search and receive proper question. 
  Search should support search by title and question's body
} do
  given!(:user) { create(:user) }
  given!(:user2) { create(:user) }
  given!(:questions) {create_list(:question, 3, author: user)}
 # perform_enqueued_jobs { your_action_that_triggers_reputation_job }

  scenario 'unauthenticated user find question by title' do
    visit questions_path
    within '.questions-search' do
      ThinkingSphinx::Test.run do
         Question.search 'Question 2'    
      end  
    end

    expect(page).to have_content 'Question 2'
  end

  scenario 'unauthenticated user find question by title' do
    visit questions_path
    within '.questions-search' do
      ThinkingSphinx::Test.run do
         Question.search 'Question 4'    
      end  
    end

    expect(page).to_not have_content 'Question 4'
    expect(page).to have_content 'No results found for'
  end

  scenario 'authenticated user find question by title' do
    sign_in(user)
    visit questions_path
    within '.questions-search' do
      ThinkingSphinx::Test.run do
         Question.search 'Question 2'    
      end  
    end

    expect(page).to have_content 'Question 2'
  end


end