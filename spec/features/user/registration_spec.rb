require 'rails_helper'

feature 'User registration', %q{
  In order to registrate User fill the registration form 
  And get the user profile
} do
  given(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:questions) {create_list(:question, 5, author: user)}


  background {visit new_user_registration_path}

  scenario 'Registration new user with valid data' do    
    fill_in 'Email', with: 'test_user@test.com'
    fill_in 'Password', with: 'qwerty'
    fill_in 'Password confirmation', with: 'qwerty'
    click_on 'Sign up'

    expect(page).to have_content 'Ask question'
    expect(page).to have_content 'My Answers'
    expect(page).to have_content 'Sign out'

    within ('.questions')  do
      questions.each do | q|
        expect(page).to have_content q.body
      end      
    end  
  end

  scenario 'Registration of existing user' do
    
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password_confirmation
    click_on 'Sign up'

    expect(page).to have_content 'Email has already been taken'
  end


  scenario 'Registration user with invalid data' do
    fill_in 'Email', with: 'test_user@'
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_on 'Sign up'

    expect(page).to have_content '2 errors prohibited this user from being saved:'
    expect(page).to have_content 'Email is invalid'
    expect(page).to have_content "Password can't be blank"
  end
end