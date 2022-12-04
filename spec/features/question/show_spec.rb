require 'rails_helper'

feature 'User can read questions', %q{
  In order to find interested question
  User can look through list of all questions
} do
  scenario 'User can read all questions'
  scenario 'User can expand question and look the answers to it'
  scenario 'Authenticated user can read only his questions'
end