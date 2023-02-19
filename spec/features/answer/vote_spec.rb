require 'rails_helper'

feature 'Authenticated user can vote for answer', %q{
  Only authenticated user can vote
  User couldn't vote if he's author of answer
  User can vote "like" or "dislike" for certain answer only one time
  (it's prohobited to vote 2 times in a line Like or Dislike)
  User can cancel his descision and after this action re-vote
  Each answer should calculate vote rating as a difference between numbers of Like and Dislike

} do
  given!(:user){create(:user)} 
  given!(:user1){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
  given!(:answer1) {create(:answer, question: question, author: user1)}
  given!(:answer2) {create(:answer, question: question, author: user2)}

  describe 'Authenticated user', js: true do
    background do
      sign_in(user1)
      visit question_path(question)
    end
    
    scenario 'Authenticated User, who is Author of the answer, cannot vote for his answer', js: true do

      within '.answers' do
        page.find("#answer_#{answer1.id}")
        expect(page).to_not have_content(/Like|Dislike/)
      end      
    end

    scenario 'Authenticated User, who is not Author of the answer, can vote for his answer', js: true do

      within '.answers' do
        page.find("#answer_#{answer2.id}")
        expect(page).to have_content(/Like|Dislike/)
      end      
    end

  end

end