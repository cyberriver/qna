shared_examples_for 'API Authorizable' do
  context 'unauthorized' do
    it 'returns 401 status if there is no access_token' do
      send(method, base_uri, headers: headers)
      expect(response.status).to eq 401
    end
    it 'returns 401 status if access_token is invalid' do
      send(method, base_uri, params: { access_token: '1234567890' }, headers: headers)
      expect(response.status).to eq 401 
    end
  end
end