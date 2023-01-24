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

      expect(page).to have_content 'Title question'
      expect(page).to have_content 'Body question'
    
    end

    scenario 'tries to ask quesiton with invalid data'do
      click_on 'Ask'

      expect(page).to have_content "Title can't be blank"
      expect(page).to have_content "Body can't be blank"
  
    end 
    
    scenario 'ASk a question with attached file' do
      fill_in 'Title', with: 'Title question'
      fill_in 'Body', with: 'Body question'

      attach_file 'File', "#{Rails.root}/spec/rails_helper.rb"
      click_on 'Ask'

      expect(page).to have_link 'rails_helper.rb'


    end
  end


  scenario 'Unauthenticated tries to ask quesiton'  do
    visit questions_path

    expect(page).not_to have_content 'Ask question' 
  end
end

