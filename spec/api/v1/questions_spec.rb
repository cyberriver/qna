require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { {"CONTENT-TYPE" => "application/json",
                   "ACCEPT" => 'application/json'} }
  let(:base_uri) { "/api/v1/questions" }

  describe 'GET /api/v1/questions' do
    let(:method) { :get }
    context 'unauthorized' do
      it 'returns 401 status if there  is no access_token' do
        get base_uri, headers: headers
        expect(response).to have_http_status(:unauthorized)
      end
      it 'returns 401 status if access_token is invalid' do
        get base_uri, params: { access_token: '1234' }, headers: headers
        expect(response).to have_http_status(:unauthorized)
      end
    end

    context 'authorized' do
      let(:user) { create(:user)}
      let(:access_token) { create(:access_token ) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let!(:answers) { create_list(:answer,3, question: question)}
      let!(:answer) { answers.first}
      let(:questions_response) {json['questions'].first}
      let(:question_response) {json['question'] }
      let!(:comments_question) { create_list(:comment, 3, commentable: question, author: user) }
      let!(:comments_answer) { create_list(:comment, 2, commentable: answer, author: user) }


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
        before { get base_uri+"/#{question.id}", params: { access_token: access_token.token }, headers: headers }
        let(:answer) { answers.first }
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
      end 
    end    
  end
end