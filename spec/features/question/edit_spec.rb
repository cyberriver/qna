require 'rails_helper'

feature 'Edit question', %q{
  in order to update the question
  Author can update the question and save it
} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}

  scenario 'Authenticated User, who is Author of the question update the question' do
    sign_in(user)
    visit questions_path
    click_on 'Edit'

    expect(page).to have_content 'Edit question'
    expect(page).to have_content "#{question.title}"  
    expect(page).to have_content "#{question.body}"
  
  end

  scenario 'Authenticated User, who is not Author of the question can not update the question' do
    sign_in(user2)
    visit questions_path
    click_on 'Edit'

    expect(page).to have_content "You don't have permissons." 
 
  end
  scenario 'Unauthenticated user could not do any actions with question' do
    visit questions_path
    click_on 'Edit'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'  
  end
end