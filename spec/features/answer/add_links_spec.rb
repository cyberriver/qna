require 'rails_helper'

feature 'User can add links to answer', %q{
  In order to provide additional info to my answer
  As an answer's author
  I'd like to be able to add links
} do
  
  given(:user) { create(:user)}
  given(:gist_url) {'https://gist.github.com/cyberriver/b3373d10e9723eb90211e920d2d4204b'}
  given!(:question) {create(:question, author: user)}
  
  scenario 'User add link when makes answer', js: true do
    sign_in(user)
    visit question_path(question)

    within '.answer' do
      fill_in 'Title', with: 'My RSPEC test answer'

      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with:gist_url

      click_button 'Make Answer' 

    end

    within '.answers' do
      expect(page).to have_link 'My gist', href: gist_url
    end   

  end

end
