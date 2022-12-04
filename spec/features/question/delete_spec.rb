require 'rails_helper'

feature 'Delete question', %q{
  In order to delete question
  Athor of question can delete it
} do
  scenario 'Authenticated user, author of question can delete it (with or without answers'
  scenario 'Authenticated user, not-author, could not delete the question of other author'
end