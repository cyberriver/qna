require 'rails_helper'

feature 'User can create the answer for question', %q{
  in order to answer the question
  User can answer the question
} do
  given!(:user){create(:user)} 
  given!(:question) {create(:question, author: user)}

  scenario 'Authenticated user can answer the question directly on the same page', js:true do
    sign_in(user)
    visit question_path(question)
    
    fill_in 'Title', with: 'My RSPEC test answer'
    click_on 'Make Answer', match: :first
    
    expect(page).to have_content "Answer succefully added to question."
  end

  scenario 'Authenticated user answer the question with invalid data', js:true do
    sign_in(user)
    visit question_path(question)
    
    fill_in 'Title', with: ''
    click_on 'Make Answer', match: :first
    
    expect(page).to have_content "Invalid data added"
  end
  scenario 'Unauthenticated user, could not answer the question', js:true do
    visit question_path(question)

    expect(page).should_not have_content 'Make Answer'
    expect(page).should_not have_content 'Title'
  end
end