require 'rails_helper'

feature 'Edit answer', %q{
  in order to update the answer
  Author can update his answers to the proper question and save it
} do
  given!(:user){create(:user)} 
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
  given!(:answers) {create(:answer, question:question, author: user)}

  scenario 'Authenticated User, who is Author of the answer update the answer', js:true do
    sign_in(user)
    visit question_path(question)
    click_on 'Edit', match: :first

    fill_in 'Title', with: 'Modified answer'
    click_button 'Save'

   
      expect(page).to have_content 'Modified answer'
       
  end

  scenario 'Authenticated User, who is not Author of the answer can not update it', js:true do
    sign_in(user2)
    visit question_path(question)

    within '.answers' do
      expect(page).should_not have_content 'Edit'
    end    
  end

end