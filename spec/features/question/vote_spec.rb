require 'rails_helper'

feature 'Question author can choose best answer', %q{
 The author of question can choose best answer by vote
 chosen answer can be only one for each question
 If early was chosen another answer then next chosen should replace the previous one
 if for question was chosen answer, than this answer should be rendered on the first place
} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
  given!(:answers) {create_list(:answer, 4, question:question, author: user2)}

  scenario 'Author of the question can choose the answer', js:true do
    sign_in(user)      
    visit question_path(question)

    within ('.answers') do   
      click_on 'Vote', match: :first
      expect(page).to have_content('Voted')
      
    end
  end

  scenario 'Author of the question can choose another one answer'

  scenario 'Not author of the question could not vote the answer' 

  scenario 'Any user should should see the first voted answer for question'


end