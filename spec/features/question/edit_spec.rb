require 'rails_helper'

feature 'Edit question', %q{
  in order to update the question
  Author can update the question and save it
} do
  given!(:user){create(:user)}
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}

  scenario 'Authenticated User, who is Author of the question update the question', js: true  do
    sign_in(user)
    visit questions_path
    click_on 'Edit', match: :first

    within "#edit-question-#{question.id}" do
      fill_in 'Title', with: 'Title question EDITED'
      fill_in 'Body', with: 'Body question EDITED'
      click_on 'Save'
    end

    expect(page).to have_content 'Title question EDITED'
    expect(page).to have_content 'Body question EDITED'  
  end

  scenario 'Authenticated User, who is Author of the question can add files', js: true do
    sign_in(user)
    visit questions_path
    click_on 'Edit', match: :first

    within "#edit-question-#{question.id}" do
      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb","#{Rails.root}/spec/spec_helper.rb"]
      
      click_on 'Save'
    end

    expect(page).to have_link 'rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb'

  end

  scenario 'Authenticated User, who is Author of the question, can delete files', js: true do
    sign_in(user)
    visit questions_path

    click_on 'Edit', match: :first

    within "#edit-question-#{question.id}" do
      attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb","#{Rails.root}/spec/spec_helper.rb"]
      
      click_on 'Save'
    end

    expect(page).to have_link 'rails_helper.rb'
    expect(page).to have_link 'spec_helper.rb'

    click_on 'Edit', match: :first

    within "#edit-question-#{question.id}" do    
      click_on 'Delete-file', match: :first
    end

    expect(page).to_not have_link 'rails_helper.rb'

  end


  scenario 'Authenticated User, who is not Author of the question can not update the question', js: true  do
    sign_in(user2)
    visit questions_path

    expect(page).to_not have_content 'Edit'
 
  end

  scenario 'Unauthenticated user could not do any actions with question', js: true  do
    visit questions_path

    expect(page).to_not have_content 'Edit'  
  end
end