require 'rails_helper'

feature 'User can read questions', %q{
  In order to find interested question
  User can look through list of all questions
} do
  given!(:user){create(:user)}
  given!(:questions) {create_list(:question, 5, author: user)}
  given!(:answers) {create_list(:answer,4, question:questions.first, author: user)}

  background {visit questions_path}

  scenario 'User can read all questions' do   
    within ('.questions')  do
      questions.each do | q|
        expect(page).to have_content q.body
      end      
    end  
  end

  scenario 'User can expand question and look the answers to it'  do
    
    click_on 'Answers', match: :first
    
    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.first.body
    
    within ('.answers') do
      questions.first.answers.each do |ans|
        expect(page).to have_content ans.title
      end 
    end
  end

  scenario 'Authenticated user as author can have access to directly to his questions'  do
    sign_in(user)
    click_on 'My Answers'

    within '.my-answers' do
      user.answers.each do |user_answer|
        expect(page).to have_content user_answer.question.title
        expect(page).to have_content user_answer.title      
      end
    end    
  end 

  scenario 'Any user can return back to home page with questions'  do    
    click_on 'Home'
    within ('.questions')  do
      questions.each do | q|
        expect(page).to have_content q.body
      end      
    end  
  end
end