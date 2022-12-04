require 'rails_helper'

feature 'User can create the answer for question', %q{
  in order to answer the question
  User can answer the question
} do
  scenario 'Authenticated user can answer the question directly on the same page'
  scenario 'Authenticated user answer the question with invalid data'
  scenario 'Unauthenticated user, could not answer the question'
end