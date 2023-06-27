require 'rails_helper'

feature 'Add comment', %q{
  in order to comment the answer
  Authenticated use can click "Comment" and add comment.
  Comment should be displayed on the same page} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
  given!(:answer) {create(:answer, question: question, author: user)}
  let(:comment) { create(:comment, commentable: question, user: user) }
  let(:comment) { create(:comment, commentable: answer, user: user) }

  scenario 'Any authenticaed user should comment the question' do
    sign_in(user2)      
    visit questions_path
      
    within(page.find(id: "question_#{question.id}")) do
        click_on 'Answers'
    end
    
    within(page.find(id: "answer_#{answer.id}")) do
      click_on 'Add Comment'
    end   
    
        fill_in 'Title', with: "Test Comment"
        click_on 'Save comment'     

    expect(page).to have_content 'Test Comment'
  end

end