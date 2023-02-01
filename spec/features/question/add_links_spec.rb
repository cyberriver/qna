require 'rails_helper'

feature 'User can add links to question', %q{
  In order to provide additional info to my question
  As an question's author
  I'd like to be able to add links
} do
  
  given(:user) { create(:user)}
  given(:gist_url) {'https://gist.github.com/cyberriver/b3373d10e9723eb90211e920d2d4204b'}
  
  scenario 'User add link when asks quesiton' do
    sign_in(user)
    visit questions_path

    click_on 'Ask question'

    fill_in 'Title', with: 'Title question'
    fill_in 'Body', with: 'Body question'

    fill_in 'Link name', with: 'My gist'
    fill_in 'Url', with:gist_url

    click_on 'Ask'

    expect(page).to have_link 'My gist', href: gist_url

  end

end
