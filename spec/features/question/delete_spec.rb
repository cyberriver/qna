require 'rails_helper'

feature 'Delete question', %q{
  In order to delete question
  Athor of question can delete it
} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
   
  scenario 'Authenticated user, author of question can delete it without answers', js: true  do
    sign_in(user)
    visit questions_path
    click_button 'Delete', match: :first

    expect(page).to_not have_content question.body   
  end

  scenario 'Authenticated user, not-author, could not delete the question ', js: true  do
    sign_in(user2)
    visit questions_path    

    expect(page).to_not have_content 'Delete'  
  end
  
  scenario 'UnAuthenticated user, could not delete the question ', js: true  do
    visit questions_path

    expect(page).to_not have_content 'Delete'    
  end
end