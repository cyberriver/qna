require 'rails_helper'

feature 'User can read all answer for the question', %q{
  In order to check answers, User can get the list of all answers to the question
} do
  scenario 'User can read all answers'
  scenario 'Authenticated user can get the list the answers where he it author'
end