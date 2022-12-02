require 'rails_helper'
FactoryBot.reload

RSpec.describe "Answers", type: :request do
  let(:test) {create(:test)}
  let(:question) {create(:question,  test: test)} 
  let(:answers) {create_list(:answer, 4,  question: question)}
  let(:answer) {create(:answer,  question: question)} 


  describe "GET /index answers" do
    before { get question_answers_path(question)}

    it 'populates an array of all answers' do          
      expect(assigns(:answers)).to match_array(answers)
    end

    it 'render index view' do      
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do 
    before {get answer_path(answer) }

    it 'assigns requested anwer to @answer' do 
      expect(assigns(:answer)).to eq answer
    end

    it 'renders view show' do           
      expect(assigns(:answer)).to render_template :show
    end
  end

  describe "GET # NEW" do    
    before {get "/questions/#{question.id}/answers/new", params: {answer: attributes_for(:answer), question_id: question.id} }

    it 'assigns to a new Answer to @answer'do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'renders view new' do           
      expect(assigns(:answer)).to render_template :new
    end    
  end

  describe "GET # EDIT" do
    before {get edit_answer_path(answer) }

    it 'assigns to editing answer to @answer'do
      expect(assigns(:answer)).to eq answer 
    end

    it 'renders view edit' do           
      expect(assigns(:answer)).to render_template :edit
    end    
  end

  describe "POST #create" do
    context 'with valid attributes' do
      it 'saves a new answer to database' do

        count = Answer.count              
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer),  question_id: question.id}
        expect(Answer.count).to eq count + 1        
      end

      it 'redirects to show view' do        
        post "/questions/#{question.id}/answers", params: {answer: attributes_for(:answer),  question_id: question.id}
        expect(response).to redirect_to assigns(:answer)
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
        expect(response).to render_template :new    
      end      
    end   
  end

  describe 'PATCH #UPDATE' do
    context 'with valid attributes' do
      it 'assignes to requested @answer' do
        patch "/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer), question: question.id} 
        expect(assigns(:answer)).to eq answer 
      end

      it 'changes answer attributes' do
        patch "/answers/#{answer.id}", params: {id: answer, answer: {title: "new title"}, question: question.id}
        answer.reload
        expect(answer.title).to eq "new title"        
      end

      it 'redirect to updated question' do
        patch "/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer), question: question.id} 
        expect(response).to redirect_to assigns(:answer)
      end      
    end

    context 'with invalid attributes' do
      before {patch "/answers/#{answer.id}", params: {id: answer, answer: attributes_for(:answer, :invalid_data), question: question.id} }

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
    let!(:answer) {create(:answer,  question: question)} 

    it 'deletes the answer' do
      expect {delete "/answers/#{answer.id}", params: {id: answer, question: question.id}}.to change(Answer, :count).by(-1)
    end

    it 'redirects to index' do
      delete "/answers/#{answer.id}", params: {id: answer, question: question.id}
      expect(response).to redirect_to question_answers_path(answer.question)
    end    
  end
end
