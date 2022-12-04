require 'rails_helper'

feature 'Edit answer', %q{
  in order to update the answer
  Author can update his answers to the proper question and save it
} do
  scenario 'Authenticated User, who is Author of the answer update the answer'
  scenario 'Authenticated User, who is not Author of the answer can not update it'
  scenario 'Unauthenticated user could not do any actions with answer'
end