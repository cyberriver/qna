require 'rails_helper'

feature 'Add comment', %q{
  in order to comment the question
  Authenticated use can click "Comment" and add comment.
  Comment should be displayed on the same page} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}

  scenario 'Any authenticaed user should comment the question', js: true do
    sign_in(user2)      
    visit questions_path

    question_data = page.find(id: "question_#{question.id}")  
      
    within(question_data) do
        click_on 'Add Comment'

        fill_in 'Value', with: "Test Comment"
        click_on 'Make Comment'  
    end

    expect(page).to have_content 'Test Comment'
  end

end