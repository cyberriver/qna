require 'rails_helper'

feature 'User can create the answer for question', %q{
  in order to answer the question
  User can answer the question
} do

  given!(:user){create(:user)} 
  given!(:question) {create(:question, author: user)}

  describe 'Authenticated user', js: true do
    
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'Authenticated user can answer the question directly on the same page' do
     
      within '.answer' do
        fill_in 'Title', with: 'My RSPEC test answer'
        click_button 'Make Answer' 

      end

      within '.answers' do
        expect(page).to have_content "My RSPEC test answer"  
      end            
    end

    scenario 'Authenticated user answer the question with invalid data' do
      
      fill_in 'Title', with: ''
      click_on 'Make Answer'
    
      within '.answer-errors' do 
        expect(page).to have_content "Title can't be blank"
      end
    end

    scenario 'Authenticated user can add several files with answer' do
      within '.answer' do
        fill_in 'Title', with: 'My RSPEC test answer'
        attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb","#{Rails.root}/spec/spec_helper.rb"]

        click_button 'Make Answer' 
      end

      within '.answers' do
        expect(page).to have_content "My RSPEC test answer"
        expect(page).to have_link "rails_helper.rb"
        expect(page).to have_link "spec_helper.rb"  
      end            
    end


  end

  scenario 'Unauthenticated user, could not answer the question', js: true do
    sign_out(user)    
    visit question_path(question)

    expect(page).to_not have_content 'Make Answer'
  end
  
end