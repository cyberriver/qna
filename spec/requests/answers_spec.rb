require 'rails_helper'
FactoryBot.reload

RSpec.describe "Answers", type: :request do
  let!(:user) {create(:user)}
  let(:question) {create(:question, author: user)} 
  let(:answers) {create_list(:answer, 4,  question: question, author: user)}
  let(:answer) {create(:answer,  question: question, author: user)} 

  describe "POST #create" do
    before { login(user)} 
    context 'with valid attributes' do
      it 'saves a new answer to database' do

        count = Answer.count                         
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer, author_id: user.id),  question_id: question.id, user_id: user.id, format: :json }
      
        expect(Answer.count).to eq count + 1        
      end

    end

    context 'with invalid attributes' do
      it 'does not save the answer' do          
        count = Answer.count
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer, :invalid_data), question_id: question.id, format: :json }         
        expect(Answer.count).to eq count       
      end
 
    end   
  end

  describe 'PATCH #UPDATE' do
    before { login(user)} 
    context 'with valid attributes' do
      it 'assignes to requested @answer' do
        patch "/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer, author_id: user.id), question: question.id,  user_id: user.id, remote: true} 
        expect(assigns(:answer)).to eq answer 
      end

      it 'changes answer attributes' do
        patch "/answers/#{answer.id}", params: {id: answer, answer: {title: "new title", question: question.id, author_id: user.id}, user_id: user.id}
        answer.reload
        expect(answer.title).to eq "new title"        
      end

      it 'redirect to updated answer' do
        patch "/questions/#{question.id}/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer, author_id: user.id, question: question.id),  user_id: user.id} 

        expect(response).to redirect_to question_path(question)
      end      
    end

    context 'with invalid attributes' do
      before {patch "/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer, :invalid_data), question: question.id,  user_id: user.id},format: :json }

      it 'does not change the question' do       
        answer.reload
        expect(answer.title).to include("Answer")        
      end

    end
  end

  describe 'DELETE #destroy' do
    before { login(user)} 
    let!(:answer) {create(:answer,  question: question)} 

    it 'deletes the answer' do
      expect {delete "/answers/#{answer.id}", params: {id: answer, question: question.id}}.to change(Answer, :count).by(-1)
    end

    it 'redirects to index' do
      delete "/answers/#{answer.id}", params: {id: answer, question: question.id}
      expect(response).to redirect_to question_path(question)
    end    
  end
end
