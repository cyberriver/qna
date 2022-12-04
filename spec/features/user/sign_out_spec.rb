require 'rails_helper'

feature 'User sign-out',%q{
  in order to sign-out, User can click "logout"
  and the it terminates the uses's session
} do
  scenario 'Authenticated user logout from any page'
  scenario 'Unauthenticated user could not logout'
end