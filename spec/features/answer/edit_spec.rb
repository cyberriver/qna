require 'rails_helper'

feature 'Edit answer', %q{
  in order to update the answer
  Author can update his answers to the proper question and save it
} do

  
  given!(:user){create(:user)} 
  given!(:user2){create(:user)}
  given!(:question) {create(:question, author: user)}
  given!(:answer) {create(:answer, question: question, author: user)}

  describe 'Authenticated user', js: true do
    background do
      sign_in(user)
      visit question_path(question)

      click_on 'Edit', match: :first
    end  
  
      scenario 'Authenticated User, who is Author of the answer, can update the answer', js: true do

        within '.answers' do
          fill_in 'Title', with: 'My RSPEC test answer EDITED'
          click_on 'Save'
        end        
        expect(page).to have_content 'My RSPEC test answer EDITED'  
        expect(page).not_to have_content answer.title
      end

      scenario 'Authenticated User, who is Author of the answer, can add files', js: true do

        within '.answers' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb","#{Rails.root}/spec/spec_helper.rb"]

          click_on 'Save'
        end
        
        expect(page).to have_link 'rails_helper.rb'
        expect(page).to have_link 'spec_helper.rb'
        
      end

      scenario 'Authenticated User, who is Author of the answer, can delete files', js: true do

        within '.answers' do
          attach_file 'File', ["#{Rails.root}/spec/rails_helper.rb","#{Rails.root}/spec/spec_helper.rb"]
          click_on 'Save'
        end

        expect(page).to have_link 'rails_helper.rb'

        click_on 'Edit', match: :first

        within '.answers' do       
          click_on 'Delete_file', match: :first          
        end  

        expect(page).to_not have_link 'rails_helper.rb'    
      end
  end 

  scenario 'Authenticated User, who is Author of the answer, can delete link' do
    within '.answers' do
      click_on 'Edit'
      click_on 'Add link'
      
      fill_in 'Link name', with: 'My gist'
      fill_in 'Url', with: google_url

      click_on 'Save'

      expect(page).to have_link 'My gist', href: google_url
      click_on 'Delete link'
      expect(page).to_not have_link 'My gist', href: google_url
    end
  end




      scenario 'Authenticated User, who is not Author of the answer can not update it', js: true do
        sign_out(user)
        sign_in(user2)  
        visit question_path(question)
  
        expect(page).to have_content answer.title
        expect(page).to_not have_content 'Edit'
      end
end

