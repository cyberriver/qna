require 'rails_helper'

feature 'User sign-out',%q{
  in order to sign-out, User can click "logout"
  and the it terminates the uses's session
} do
  given(:user){create(:user)}

  scenario 'Authenticated user logout from any page' do
    sign_in(user)

    visit questions_path
    click_on 'Sign out'

    expect(page).to_not have_content 'Ask question'
    expect(page).to_not have_content 'My Answers'
    expect(page).to_not have_content 'Sign out'
  end

  scenario 'Unauthenticated user could not logout' do
    visit questions_path
    expect(page).to have_no_content 'Signed out'
  end
end