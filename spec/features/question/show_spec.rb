require 'rails_helper'

feature 'User can read questions', %q{
  In order to find interested question
  User can look through list of all questions
} do
  given!(:user1) {create(:user)}
  given!(:user2){create(:user)}
  given!(:questions) {create_list(:question, 5, author: user1)}
  given!(:answers) {create_list(:answer,4, question:questions.first, author: user2)}

  background {visit questions_path}

  scenario 'User can read all questions' do         
    expect(page).to have_content 'Questions List'
  end

  scenario 'User can expand question and look the answers to it' do
    
    
    #binding.irb
    click_on 'Show', match: :first

    expect(page).to have_content "#{questions.first.title}"
    expect(page).to have_content "#{questions.first.body}"
    expect(page).to have_content "Answer"
  end

  scenario 'Authenticated user as author can have access to directly to his questions and its answers'  
end