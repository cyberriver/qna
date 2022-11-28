require 'rails_helper'
FactoryBot.reload


RSpec.describe "Questions", type: :request do
  let(:test) {create(:test)}
  let(:questions) {create_list(:question, 5,  test: test)}
  let(:question) {create(:question,  test: test)} 


  describe "GET /index" do
    before { get questions_path}

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
    before {get '/questions/new', params: {question: attributes_for(:question), test_id: test.id} }

    it 'assigns to a new Question to @question'do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'renders view new' do           
      expect(assigns(:question)).to render_template :new
    end
    
  end

  describe "GET # EDIT" do
    before {get edit_question_path(question) }

    it 'assigns to editing question to @question'do
      expect(assigns(:question)).to eq question 
    end

    it 'renders view edit' do           
      expect(assigns(:question)).to render_template :edit
    end
    
  end

  describe "POST #create" do
    context 'with valid attributes' do
      it 'saves a new question to database' do

        count = Question.count              
        post '/questions', params: {question: attributes_for(:question), test_id: test.id}
        expect(Question.count).to eq count + 1
        
      end

      it 'redirects to show view' do
        
        post '/questions', params: {question: attributes_for(:question),test_id: test.id}
        expect(response).to redirect_to assigns(:question)
      end
    end

    context 'with invalid attributes' do
      it 'does not save the question' do          
        count = Question.count
        post '/questions', params: {question: attributes_for(:question, :invalid_data), test_id: test.id}          
        expect(Question.count).to eq count
       
      end

      it 're-renders form new' do
        post '/questions', params: {question: attributes_for(:question, :invalid_data), test_id: test.id}
        expect(response).to render_template :new    
      end      
    end    
  end

  describe 'PATCH #UPDATE' do
    context 'with valid attributes' do
      it 'assignes to requested @question' do
        patch "/questions/#{question.id}", params: {id: question, question: attributes_for(:question, :invalid_data), test_id: test.id} 
        expect(assigns(:question)).to eq question 
      end

      it 'changes question attributes' do
        patch "/questions/#{question.id}", params: {id: question, question: {title: "new title", body: "new body"}, test_id: test.id}
        question.reload
        expect(question.title).to eq "new title"
        expect(question.body).to eq "new body" 
      end

      it 'redirect to updated question' do
        patch "/questions/#{question.id}", params: {id: question, question: attributes_for(:question, :invalid_data), test_id: test.id} 
        expect(response).to render_template :show
      end
      
    end

    context 'with invalid attributes' do
      it 'assignes to requested @question'
      it 'changes question attributes'
      it 'redirect to updated question'
    end
  end
end
