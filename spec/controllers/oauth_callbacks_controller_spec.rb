require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  #Github
  describe 'Github' do
    it 'finds user from oauth data' do
      expect(User).to receive(:find_for_oauth)
      get :github      
    end

    context 'user exists' do
      it 'login user if '
      it 'redirects to root path'
    end

    context 'user doesnt exist' do
      
      it 'redirects to root path ' do
        allow(User).to receive(:find_for_oauth)
        get :github  
      
        expect(response).to redirect_to root_path
      end

      it 'does not login user' do
        allow(User).to receive(:find_for_oauth)
        get :github 
        
        expect(subject.send(:current_user)).to_not be     
        
      end
   end
  end
end