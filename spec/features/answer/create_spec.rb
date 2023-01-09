require 'rails_helper'

feature 'User can create the answer for question', %q{
  in order to answer the question
  User can answer the question
} do

  before(:all) do
    Capybara.current_driver = :selenium
  end

  given!(:user){create(:user)} 
  given!(:question) {create(:question, author: user)}

  scenario 'Authenticated user can answer the question directly on the same page', js: true do
    sign_in(user)
    visit question_path(question)
    
    within '.answer' do
      fill_in 'Title', with: 'My RSPEC test answer'
      click_button 'Make Answer' 
      page.execute_script("$('.answers').append('<%= j render @answer %>');")     
    end
    
    expect(page).to have_content "My RSPEC test answer"   
        
  end

  scenario 'Authenticated user answer the question with invalid data', js: true do
    sign_in(user)
    visit question_path(question)
    
    fill_in 'Title', with: ''
    click_on 'Make Answer'
   
    within '.answer-errors' do 
      expect(page).to have_content "Title can't be blank"
    end
  end

  scenario 'Unauthenticated user, could not answer the question', js: true do
    visit question_path(question)

    expect(page).should_not have_content 'Make Answer'
    expect(page).should_not have_content 'Title'
  end
end