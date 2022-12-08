require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  Athor of answer can delete it
} do

  given!(:user){create(:user)} 
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
  given!(:answers) {create(:answer, question:question, author: user)}


  scenario 'Authenticated user, author of answer can delete it ' do
    sign_in(user)
    click_on 'My Answers'
    click_on 'Delete', match: :first
    
    expect(page).to have_content 'Answer succefully deleted.'

  end
  scenario 'Authenticated user, not-author, could not delete the answer' do
    visit question_path(question)

    expect(page).should_not have_content 'Delete'
  end
end