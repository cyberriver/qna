require 'rails_helper'

feature 'User can create question', %q{
  In order to get answer from community
  As an authenticated user 
  I'd like to be able to ask the question
} do

  given(:user) {create(:user)} 

  describe 'Authenticated user' do
    background do
      sign_in(user)

      visit questions_path
      click_on 'Ask question'
    end
    scenario 'tries to ask quesiton' do
      fill_in 'Title', with: 'Title question'
      fill_in 'Body', with: 'Body question'
      click_on 'Ask'

      expect(page).to have_content 'Your question successfully created.'
      expect(page).to have_content 'Title question'
      expect(page).to have_content 'Body question'
    
    end

    scenario 'tries to ask quesiton with invalid data' do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
  
    end    
  end


  scenario 'Unauthenticated tries to ask quesiton' do
    visit questions_path
    click_on 'Ask question'
    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end

