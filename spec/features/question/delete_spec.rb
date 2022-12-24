require 'rails_helper'

feature 'Delete question', %q{
  In order to delete question
  Athor of question can delete it
} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:questions) {create(:question, author: user)}
   
  scenario 'Authenticated user, author of question can delete it without answers' do
    sign_in(user)
    visit questions_path
    click_button 'Delete'

    expect(page).to have_content 'Your question successfully deleted.'    
  end

  scenario 'Authenticated user, not-author, could not delete the question ' do
    sign_in(user2)
    visit questions_path    
    click_button 'Delete'

    expect(page).to have_content "You don't have permissons."  
  end
  
  scenario 'UnAuthenticated user, could not delete the question ' do
    visit questions_path
    click_button 'Delete'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'  
  end
end