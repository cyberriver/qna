require 'rails_helper'
FactoryBot.reload


RSpec.describe AnswersController, type: :controller do
  include Devise::Test::ControllerHelpers 
  let!(:user) {create(:user)}
  let(:question) {create(:question, author: user)} 
  let(:answers) {create_list(:answer, 4,  question: question, author: user)}
  let(:answer) {create(:answer,  question: question, author: user)} 

  describe "POST #create" do
    before { sign_in(user) }
    context 'with valid attributes' do
      it 'saves a new answer to database' do
        count = Answer.count                         
        post :create, params: {answer: attributes_for(:answer, question_id: question.id, author_id: user.id),  question_id: question.id, user_id: user.id, format: :html }
        expect(Answer.count).to eq count + 1        
      end

    end

    context 'with invalid attributes' do
      it 'does not save the answer' do          
        count = Answer.count
        post :create, params: {answer: attributes_for(:answer, :invalid_data), question_id: question.id, format: :html }         
        expect(Answer.count).to eq count       
      end
 
    end   
  end

  describe 'PATCH #UPDATE' do
    before { sign_in(user) }
    context 'with valid attributes' do
      it 'assignes to requested @answer' do
        patch :update, params: {id: answer, answer: attributes_for(:answer, question_id: question.id, author_id: user.id), question: question.id,  user_id: user.id, format: :js } 
        expect(assigns(:answer)).to eq answer 
      end

      it 'changes answer attributes' do
        patch :update, params: {id: answer, answer: {title: "new title", question: question.id, author_id: user.id}, user_id: user.id, format: :js}
        answer.reload
        expect(answer.title).to eq "new title"        
      end

      it 'redirect to updated answer' do
        patch :update, params: {id: answer, answer: attributes_for(:answer, question_id: question.id, author_id: user.id, question: question.id),  user_id: user.id, format: :js} 
        expect(response).to redirect_to question_path(question)
      end      
    end

    context 'with invalid attributes' do
      before {patch :update, params: {id: answer, answer: attributes_for(:answer, :invalid_data), question: question.id,  user_id: user.id}, format: :js}

      it 'does not change the question' do       
        answer.reload
        expect(answer.title).to include("Answer")        
      end

    end
  end

  describe 'DELETE #destroy' do
    before { sign_in(user) }
    let!(:answer) {create(:answer,  question: question)} 

    it 'deletes the answer' do
      expect {delete :destroy, params: {id: answer, question: question.id}, format: :js}.to change(Answer, :count).by(-1)
    end

    it 'redirects to index' do
      delete :destroy, params: {id: answer, question: question.id}, format: :js
      expect(response).to redirect_to question_path(question)
    end    
  end
end
