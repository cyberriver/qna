require 'rails_helper'
FactoryBot.reload

RSpec.describe "Questions", type: :request do
  let(:user) {create(:user)}  
  let(:questions) {create_list(:question, 5, author: user)}
  let(:question) {create(:question, author: user)}


  describe "GET /index" do
    
    before {questions}
    before {get questions_path}
 
    it 'populates an array of all questions' do          
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'render index view' do      
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do 
    before {get question_path(question) }

    it 'assigns requested question to @question' do 
      expect(assigns(:question)).to eq question
    end

    it 'renders view show' do           
      expect(assigns(:question)).to render_template :show
    end
  end

  describe "GET # NEW" do    
    before { login(user)} 
    before { get '/questions/new'}

    it 'assigns to a new Question to @question'do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'assigns to a new Question to @question'do
    #expect(assigns(:question)).links.first).to be_
    end

    it 'renders view new' do           
      expect(assigns(:question)).to render_template :new
    end    
  end

  describe "GET # EDIT" do
    before { login(user)} 
    before {get edit_question_path(question) }

    it 'assigns to editing question to @question'do
      expect(assigns(:question)).to eq question 
    end

    it 'renders view edit' do           
      expect(assigns(:question)).to render_template :edit
    end    
  end

  describe "POST #create" do
    before { login(user)} 
    context 'with valid attributes' do
      it 'saves a new question to database' do

        count = Question.count              
        post '/questions', params: {question: attributes_for(:question)}
        expect(Question.count).to eq count + 1        
      end

      it 'redirects to show view' do        
        post '/questions', params: {question: attributes_for(:question)}
        expect(response).to redirect_to questions_path
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do          
        count = Question.count
        post '/questions', params: {question: attributes_for(:question, :invalid_data)}          
        expect(Question.count).to eq count       
      end

      it 're-renders form new' do
        post '/questions', params: {question: attributes_for(:question, :invalid_data)}
        expect(response).to render_template :new    
      end      
    end    
  end

  describe 'PATCH #UPDATE' do
    before { login(user)} 
    context 'with valid attributes' do
      it 'assignes to requested @question' do
        patch "/questions/#{question.id}", params: {id: question, question: attributes_for(:question)} 
        expect(assigns(:question)).to eq question 
      end

      it 'changes question attributes' do
        patch "/questions/#{question.id}", params: {id: question, question: {title: "new title", body: "new body"}}
        question.reload
        expect(question.title).to eq "new title"
        expect(question.body).to eq "new body" 
      end

      it 'redirect to updated question' do
        patch "/questions/#{question.id}", params: {id: question, question: attributes_for(:question)} 
        expect(response).to redirect_to questions_path
      end      
    end

    context 'with invalid attributes' do
      before {patch "/questions/#{question.id}", params: {id: question, question: attributes_for(:question, :invalid_data)}}

      it 'does not change the question' do    
        question.reload
        expect(question.title).to include("Question") 
        expect(question.body).to eq "MyText"
      end
      it 're-renders view edit' do       
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { login(user)} 
    let!(:question) {create(:question, author: user)} 
    it 'deletes the question' do
      expect {delete "/questions/#{question.id}", params: {id: question}}.to change(Question, :count).by(-1)
    end

    it 'redirects to index' do
      delete "/questions/#{question.id}", params: {id: question}
      expect(response).to redirect_to questions_path
    end    
  end
end
