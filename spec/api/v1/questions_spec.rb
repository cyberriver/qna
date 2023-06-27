require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { {"CONTENT-TYPE" => "application/json",
                   "ACCEPT" => 'application/json'} }
  let(:base_uri) { "/api/v1/questions" }

  describe 'GET /api/v1/questions' do
    let(:method) { :get }
    it_behaves_like 'API Authorizable' 

    context 'authorized' do
      let(:user) { create(:user)}
      let(:access_token) { create(:access_token,resource_owner_id: user.id ) }
      let!(:questions) { create_list(:question, 2, author:user) }
      let(:question) { questions.first }
      let!(:answers) { create_list(:answer,3, question: question, author:user)}
      let!(:answer) { answers.first}
      let(:questions_response) {json['questions'].first}
      let(:question_response) {json['question'] }
      let!(:comments_question) { create_list(:comment, 3, commentable: question, author: user) }
      let!(:comments_answer) { create_list(:comment, 2, commentable: answer, author: user) }
      let!(:url){'https://gist.github.com/cyberriver/b3373d10e9723eb90211e920d2d4204b'}
      let!(:links_question) { create_list(:link, 3, linkable: question, url: url) }
     

      context 'request for questions data' do
        before { get base_uri, params: { access_token: access_token.token }, headers: headers }

        it 'returns 200 status' do       
          expect(response).to have_http_status(:success)
        end

        it 'returns list of questions' do
          expect(json['questions'].size).to eq questions.count
        end

        it 'returns all public data' do 
          %w[title body author_id created_at updated_at].each do |attr|
            expect(questions_response[attr]).to eq question.send(attr).as_json
          end
        end
      end

      context 'request for question data' do
        before do
          question.files.attach(
            io: File.open("#{Rails.root}/spec/rails_helper.rb"),
            filename: 'rails_helper.rb',
            content_type: 'application/rb'
          )

          question.files.attach(
            io: File.open("#{Rails.root}/spec/spec_helper.rb"),
            filename: 'spec_helper.rb',
            content_type: 'application/rb'
          )
          get base_uri+"/#{question.id}", params: { access_token: access_token.token }, headers: headers 
        end
        
        let(:answer_response) { question_response['answers'].first }
        let(:comment_response) { question_response['comments'].first }


        it 'returns all public data of requested question' do 
          %w[title body author_id created_at updated_at].each do |attr|
            expect(question_response[attr]).to eq question.send(attr).as_json
          end
        end

        it 'returns list of answers' do
          expect(question_response['answers'].size).to eq answers.count
        end

        it 'returns all public answer data for requested question' do 
          %w[title author_id created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
        
        it 'returns list of comments' do
          expect(question_response['comments'].size).to eq comments_question.count
        end

        it 'returns all public comment data for requested question' do
          %w[title author_id created_at updated_at].each do |attr|
            expect(comment_response[attr]).to eq comments_question.first.send(attr).as_json
          end
        end

        it 'returns the list of files' do
          expect(question_response['files'].size).to eq question.files.count
        end

        it 'returns the  public file data: file full path' do
          expect(question_response['files'].first).to eq rails_blob_path( question.files.first, only_path: true)
        end

        it 'returns the list of links' do
          expect(question_response['links'].size).to eq question.links.count
        end
      end
      
      context 'CRUD operations with question' do
        it 'it creates new question' do
            post base_uri, params:{
              access_token: access_token.token,
              question: {
                title: "Request API Question", 
                body: "Is it Success?", 
                author_id: user.id
             }
           }.to_json, headers: headers
            expect(response).to have_http_status(:success)
          end

          it 'it changes the question' do
            patch "#{base_uri}/#{question.id}", params: {
                                                  access_token: access_token.token,
                                                  question: {
                                                    title: "CHANGED API Question", 
                                                    body: "Is it Success?", 
                                                    author_id: user.id
                                                  }
                                                }.to_json, headers: headers
            expect(response.body).not_to be_empty
            expect(question_response['title']).to eq "CHANGED API Question"
          end

          it 'it deletes the question' do
            delete "#{base_uri}/#{question.id}", params: {
                                                  access_token: access_token.token,                                                 
                                                }.to_json, headers: headers

            expect(response).to have_http_status(:success)      
          end

          it 'it creates new question' do
            post base_uri, params:{
              access_token: access_token.token,
              question: {
                title: "Request API Question", 
                body: "Is it Success?", 
                author_id: user.id
             }
           }.to_json, headers: headers
            expect(response).to have_http_status(:success) 
          end
      end

      context 'CRUD operations with answer' do
        it 'it creates new answer for the question' do
            post "#{base_uri}/#{question.id}/answers", params:{
                                                access_token: access_token.token,
                                                answer: {
                                                  title: "Request API Answer",
                                                  question_id: question.id,
                                                  author_id: user.id
                                                  } 
                                                }.to_json, headers: headers
            expect(response).to have_http_status(:success)
          end
         
      end
    end    
  end
end