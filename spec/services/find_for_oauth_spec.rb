require 'rails_helper'

RSpec.describe FindForOauth do
  let!(:user) { create(:user) }
  let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456') }
  subject { FindForOauth.new(auth) }

  context 'user already has authorization through socials' do
    it 'returns the user' do
      user.authorizations.create(provider: 'facebook', uid: '123456')
      expect(subject.call).to eq user
    end
  end

  context 'user already has NOT authorization through socials' do
    context 'user already exists in our db' do
      let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: user.email }) }
      it 'doesnt create new user in our db' do
        expect { subject.call }.to_not change(User, :count)
      end
      it 'create authorization for user in authorizations table of our db' do
        expect { subject.call }.to change(user.authorizations, :count).by(1)
      end
      it 'create authorization for user in authorizations table of our db with valid data' do
        user = subject.call
        authorization = user.authorizations.first

        expect(authorization.provider).to eq auth.provider
        expect(authorization.uid).to eq auth.uid
      end
      it 'returns the user' do
        expect(subject.call).to eq user
      end
    end
  end

  context 'user doesnot exists in our db' do
    let(:auth) { OmniAuth::AuthHash.new(provider: 'facebook', uid: '123456', info: { email: 'new_user@gmail.com' }) }
    it 'creates new user in our db' do
      expect { subject.call }.to change(User, :count).by(1)
    end
    it 'returns new user' do
      expect(subject.call).to be_a(User)
    end
    it 'fills user email' do
      user = subject.call
      expect(user.email).to eq auth.info[:email]
    end
    it 'creates authorization for user in authorizations table of our db' do
      user = subject.call
      expect(user.authorizations).to_not be_empty
    end
    it 'creates authorization for user in authorizations table of our db with provider and uid' do
      authorization = subject.call.authorizations.first
      expect(authorization.provider).to eq auth.provider
      expect(authorization.uid).to eq auth.uid
    end
  end
end