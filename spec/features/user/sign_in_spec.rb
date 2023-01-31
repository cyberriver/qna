require 'rails_helper'

feature 'User can sign in',  %q{
  I order to ask questions
  As an unauthenticated user 
  I'd like to able to sign in
} do

  given(:user) {create(:user)} 
  given!(:questions) {create_list(:question, 5, author: user)}

  background {visit new_user_session_path} 

  scenario 'Registred user tries to sign in' do
      
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    
    expect(page).to have_content 'Ask question'
    expect(page).to have_content 'My Answers'
    expect(page).to have_content 'Sign out'

    within ('.questions')  do
      questions.each do | q|
        expect(page).to have_content q.body
      end      
    end  
      
  end

  scenario 'Unregistred user tries to sign in' do
    
    fill_in 'Email', with: 'qwerty'
    fill_in 'Password', with: 'invalidr@test.com'
    click_on 'Log in'
    
    expect(page).to have_content 'Invalid Email or password'
  end
end