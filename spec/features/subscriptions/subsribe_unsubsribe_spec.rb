require 'rails_helper'

feature 'User can subsribe/unsubsribe to question', %q{
  In order to get or not to get notifications about new answer
} do

  given!(:user) { create(:user) }
  given!(:question) { create(:question, author: user) }
  given!(:subscription) { create(:subscription, user: user, question: question) }
  given!(:other_question) { create(:question) }

  describe 'Authenticated user' do
    background do
      sign_in(user)
    end

    scenario "Already subscribed if author of question" do
      visit question_path(question)
      expect(page).to have_link "Unsubscribe"
    end

    scenario "Can subscribe on other_question" do
      visit question_path(other_question)
      click_on 'Subscribe'
      visit question_path(other_question)
      expect(page).to have_link "Unsubscribe"
    end

    scenario "Can unsubscribe from any question" do
      visit question_path(question)
      click_on 'Unsubscribe'
      visit question_path(question)
      expect(page).to have_link "Subscribe"
    end
  end

  describe 'Unauthenticated user' do
    scenario "Cant subscribed" do
      visit question_path(question)
      expect(page).to_not have_link "Subscribe"
      expect(page).to_not have_link "Unsubscribe"
    end
  end
end