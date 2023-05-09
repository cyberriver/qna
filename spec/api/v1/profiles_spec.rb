require 'rails_helper'

describe 'Profiles API', type: :request do
  let(:headers) { {"CONTENT-TYPE" => "application/json",
                   "ACCEPT" => 'application/json'} }
  let(:base_uri) { "/api/v1/profiles/me" }

  describe 'GET api/v1/profiles/me' do
    context 'unauthorized' do
      it 'returns 401 status if there  is no access_token' do
        get base_uri, headers: headers
        expect(response).to have_http_status(:unauthorized)
      end
      it 'returns 401 status if access_token is invalid' do
        get base_uri, params: { access_token: '1234' }, headers: headers
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'authorized' do
      let(:me) { create(:user) }
      let(:application) { create(:oauth_application)}
      let(:access_token) { create(:access_token, application: application, resource_owner_id: me.id ) }

      before { get base_uri, params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns all public data' do      

        %w[id email admin created_at updated_at].each do |attr|
          expect(json[attr]).to eq me.send(attr).as_json
        end
      end

      it 'does not return private data' do 
        %w[password encrypted_password].each do |attr|
          expect(json).to_not have_key(attr)
        end
      end

    end    
  end  
end
