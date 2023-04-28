require 'rails_helper'

feature 'Add comment', %q{
  in order to comment the question
  Authenticated use can click "Comment" and add comment.
  Comment should be displayed on the same page} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}

  scenario 'Any authenticaed user should comment the question', js: true do
    Capybara.using_session('user2') do
      sign_in(user2)      
      visit question_path(question.id)
    end

    Capybara.using_session('user') do
      sign_in(user)      
      visit question_path(question.id)
    end

    Capybara.using_session('user2') do

      click_on 'Add Comment'

      within '.new-comment' do
        fill_in 'Title', with: "Test Comment Capybara"
        click_on 'Save comment'   
      end        
  
        expect(page).to have_content 'Test Comment Capybara'
    end

    Capybara.using_session('user') do
      expect(page).to have_content 'Test Comment Capybara'
 
    end 
  end

end