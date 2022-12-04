require 'rails_helper'

feature 'Edit question', %q{
  in order to update the question
  Author can update the question and save it
} do
  scenario 'Authenticated User, who is Author of the question update the question'
  scenario 'Authenticated User, who is not Author of the question can not update the question'
  scenario 'Unauthenticated user could not do any actions with question'
end