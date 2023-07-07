require 'rails_helper'

RSpec.describe SubscriptionsController, type: :controller do

  describe 'POST#Create' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:other) { create(:question) }

    context 'authorized user' do
      before { login(user) }

      it 'creates subscription in the db' do
        expect { post :create, params: { question_id: question }, format: :json }.to change(Subscription, :count).by(1)
      end

      it 'not create new subscription if subscription exists' do
        5.times do
          post :create, params: { question_id: question }, format: :json
        end
        expect(Subscription.count).to eq 1
      end
    end

    context 'unauthorized user' do
      it 'cant create new subscription' do
        expect { post :create, params: { question_id: question } }.to_not change(Subscription, :count)
      end
    end
  end

  describe 'DELETE#Destroy' do
    let(:user) { create(:user) }
    let!(:question) { create(:question, user: user) }
    let!(:subscription) { create(:subscription, user: user, question: question) }

    context 'authorized user' do
      before { login(user) }

      context 'subscription exists' do
        it 'this cancels the subscription' do
          expect { delete :destroy, params: { id: subscription }, format: :json }.to change(Subscription, :count).by(-1)
        end
      end
    end

    context 'unauthorized user' do
      it 'cant cancel the subscription' do
        expect { delete :destroy, params: { id: subscription } }.to_not change(Subscription, :count)
      end
    end
  end
end