module FeatureHelpers
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
  
  def sign_out(user)
    visit destroy_user_session_path 
  end

  def reload_page
    visit current_path
  end

  def logger(par)
    puts "PARAMETER #{par}"
    puts par
  end
end



