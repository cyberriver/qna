require 'rails_helper'

RSpec.describe User, type: :model do
  it {should validate_presence_of :email }
  it {should validate_presence_of :password } 
  it {should have_many(:authorizations).dependent(:destroy)}
  
  it { should have_many(:comments).dependent(:destroy) }

  describe '.find_for_oauth' do
    let!(:user) {create(:user)}
    let!(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid:'123456')}
    let(:service) { double('FindForOauth')}

    it 'calls FindForOauth' do
      expect(FindForOauth).to receive(:new).with(auth).and_return(service)
      expect(service).to receive(:call)
      User.find_for_oauth(auth)
    end

   
  
  end
end
