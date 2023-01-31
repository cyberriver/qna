require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  Athor of answer can delete it
} do

  given!(:user){create(:user)} 
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}

  background do
    sign_in(user)
    visit question_path(question)
    fill_in 'Title', with: 'My RSPEC test answer'
    click_button 'Make Answer' 

  end

    scenario 'Authenticated user, author of answer can delete it ', js: true do  
      click_button 'Delete', match: :first
      
      expect(page).to_not have_content 'My RSPEC test answer'  
    end

    scenario 'Authenticated user, not-author, could not delete the answer', js: true do
      sign_out(user)
      sign_in(user2)  
      visit question_path(question)

      expect(page).to have_content 'My RSPEC test answer'
      expect(page).to_not have_content 'Delete'
    end
    
end