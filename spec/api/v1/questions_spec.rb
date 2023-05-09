require 'rails_helper'

describe 'Questions API', type: :request do
  let(:headers) { {"CONTENT-TYPE" => "application/json",
                   "ACCEPT" => 'application/json'} }
  let(:base_uri) { "/api/v1/questions" }

  describe 'GET /api/v1/questions' do
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
      let(:access_token) { create(:access_token ) }
      let!(:questions) { create_list(:question, 2) }
      let(:question) { questions.first }
      let(:question_response) { json.first }
      let!(:answers) { create_list(:answer,3, question: question)}

      before { get base_uri, params: { access_token: access_token.token }, headers: headers }

      it 'returns 200 status' do
        expect(response).to have_http_status(:success)
      end

      it 'returns list of questions' do
        expect(json.size).to eq 2
      end

      it 'returns all public data' do 
        %w[title body author_id created_at updated_at].each do |attr|
          expect(question_response[attr]).to eq question.send(attr).as_json
        end
      end

      describe 'answers' do
        let(:answer) { answers.first }
        let(:answer_response) { question_response['answers'].first }

        it 'returns list of answers' do
          expect(question_response['answers'].size).to eq 3
        end

        it 'returns all public data' do 
          %w[title author_id created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
      end
    end    
  end
end