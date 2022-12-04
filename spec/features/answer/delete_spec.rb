require 'rails_helper'

feature 'Delete answer', %q{
  In order to delete answer
  Athor of answer can delete it
} do
  scenario 'Authenticated user, author of answer can delete it '
  scenario 'Authenticated user, not-author, could not delete the answer'
end