require 'rails_helper'

RSpec.describe OauthCallbacksController, type: :controller do

  before do
    @request.env['devise.mapping'] = Devise.mappings[:user]
  end

  #Github
  describe 'Github' do
    let!(:oauth_data) { {'provider'=>'github', 'uid'=>123}}

    it 'finds user from oauth data' do
      allow(request.env).to receive(:[]).and_call_original
      allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data)
      expect(User).to receive(:find_for_oauth).with(oauth_data)
      get :github      
    end

    context 'user exists' do
      let!(:user) {create(:user)}

      before do
        allow(User).to receive(:find_for_oauth).and_return(user)
        get :github
      end

      it 'login user if ' do        
        expect(subject.send(:current_user)).to eq user 
      end
      it 'redirects to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'user doesnt exist' do

      before do
        allow(User).to receive(:find_for_oauth)
        get :github  
      end
      
      it 'redirects to root path ' do      
        expect(response).to redirect_to root_path
      end

      it 'does not login user' do        
        expect(subject.send(:current_user)).to_not be             
      end
   end
  end

  #VK
  describe 'Vkontakte' do
    let(:oauth_data) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: '123456', info: { email: user.email }) }
    let(:oauth_data_invalid) { OmniAuth::AuthHash.new(provider: 'vkontakte', uid: '123456', info: { email: '' }) }

    context 'user exists' do
      let!(:user) {create(:user)}

      context 'provider does not return email' do
        it 'render view to enter correct email for verification' do
          allow(request.env).to receive(:[]).and_call_original
          allow(request.env).to receive(:[]).with('omniauth.auth').and_return(oauth_data_invalid)
          get :vkontakte


          
        end
        it 'sends email with confirmation link'
        it 'creates authorization after confirmation link clicked'
        it 'check only one time email for athorization for login'
      end

    end

    context 'user doesnt exist' do
   end
  end
end