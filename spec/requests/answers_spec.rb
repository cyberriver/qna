require 'rails_helper'
FactoryBot.reload

RSpec.describe "Answers", type: :request do
  let!(:user) {create(:user)}
  let(:question) {create(:question, author: user)} 
  let(:answers) {create_list(:answer, 4,  question: question, author: user)}
  let(:answer) {create(:answer,  question: question, author: user)} 


  describe "GET # EDIT" do
    before { login(user)} 
    before {get edit_answer_path(answer) }

    it 'assigns to editing answer to @answer'do
      expect(assigns(:answer)).to eq answer 
    end

    it 'renders view edit' do           
      expect(assigns(:answer)).to render_template :edit
    end    
  end

  describe "POST #create" do
    before { login(user)} 
    context 'with valid attributes' do
      it 'saves a new answer to database' do

        count = Answer.count                         
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer, author_id: user.id),  question_id: question.id, user_id: user.id}
      
        expect(Answer.count).to eq count + 1        
      end

      it 'redirects to question view' do        
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer, author_id: user.id),  question_id: question.id, user_id: user.id}
        expect(response).to redirect_to question_path(question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do          
        count = Answer.count
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer, :invalid_data),  question_id: question.id}         
        expect(Answer.count).to eq count       
      end

      it 're-renders form new' do
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer, :invalid_data),  question_id: question.id}  
        expect(response).to redirect_to question_path(question)    
      end      
    end   
  end

  describe 'PATCH #UPDATE' do
    before { login(user)} 
    context 'with valid attributes' do
      it 'assignes to requested @answer' do
        patch "/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer, author_id: user.id), question: question.id,  user_id: user.id} 
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
      before {patch "/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer, :invalid_data), question: question.id,  user_id: user.id} }

      it 'does not change the question' do       
        answer.reload
        expect(answer.title).to include("Answer")        
      end

      it 're-renders view edit' do      
        expect(response).to render_template :edit
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
