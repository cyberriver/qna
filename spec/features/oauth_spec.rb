require 'rails_helper'
require 'capybara/email/rspec'

feature 'Oauth authentication', %q{
  In order to easy sign up
  And In order to easy sign in
  User can authenticate via social networks
} do
  
  given(:user) { create(:user) }
  background { visit new_user_session_path }

  scenario 'Sign in with Github with valid data' do
    click_on 'Sign in with GitHub'
    expect(page).to have_content 'Successfully authenticated from GitHub account.'
  end

  scenario 'Sign in with Github with invalid data' do
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
    click_on 'Sign in with GitHub'
    expect(page).to have_content 'Could not authenticate you from GitHub'
  end

  scenario 'Sign in with VK with valid data' do
    click_on 'Sign in with Vkontakte'
    expect(page).to have_content 'Successfully authenticated from VK account.'
  end

  scenario 'Sign in with VK with invalid data' do
    OmniAuth.config.mock_auth[:vkontakte] = :invalid_credentials
    click_on 'Sign in with Vkontakte'
    expect(page).to have_content 'Could not authenticate you from Vkontakte'
  end

  scenario 'Sign in with VK without email' do
    OmniAuth.config.mock_auth[:vkontakte] = OmniAuth::AuthHash.new({
      'provider' => 'vkontakte',
      'uid' => '123',
      'info' => { 'name' => 'username' }
    })

    click_on 'Sign in with Vkontakte'
    expect(page).to have_content 'Please clarify you email to complete registration'

    fill_in 'Email', with: 'sample@vk.com'
    click_on 'Submit'

    open_email('sample@vk.com')
    expect(current_email).to have_content 'Please click on confirm to finish registration in QNA service'
    current_email.click_link 'Confirm'
    expect(page).to have_button 'Log out'
  end
end
