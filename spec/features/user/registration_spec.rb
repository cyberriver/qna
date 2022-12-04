require 'rails_helper'

feature 'User registration', %q{
  In order to registrate User fill the registration form 
  And get the user profile
} do
  scenario 'Registration new user with valid data'
  scenario 'Registration existing user with vali data'
  scenario 'Registration new user with invalid data'
end