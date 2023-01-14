require 'rails_helper'

feature 'Edit answer', %q{
  in order to update the answer
  Author can update his answers to the proper question and save it
} do

  
  given!(:user){create(:user)} 
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
  given!(:answer) {create(:answer, question: question, author: user)}
  
      scenario 'Authenticated User, who is Author of the answer update the answer', js: true do
        sign_in(user)
        visit question_path(question)        

        click_on 'Edit', match: :first
        within '.answers' do
          fill_in 'Title', with: 'My RSPEC test answer EDITED'
          click_on 'Save'
        end        
        expect(page).to have_content 'My RSPEC test answer EDITED'  
        expect(page).not_to have_content answer.title
      end
  
      scenario 'Authenticated User, who is not Author of the answer can not update it', js: true do
        sign_out(user)
        sign_in(user2)  
        visit question_path(question)
  
        expect(page).to have_content answer.title
        expect(page).to_not have_content 'Edit'
      end
 

end