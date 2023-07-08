require 'rails_helper'

describe 'Answer API', type: :request do
  let(:headers) { {"CONTENT-TYPE" => "application/json",
                   "ACCEPT" => 'application/json'} }
  let(:base_uri) { "/api/v1/answers" }

  describe 'GET /api/v1/answers' do
    let(:method) { :get }
    it_behaves_like 'API Authorizable'

    context 'authorized' do
      let(:user) { create(:user)}
      let(:access_token) { create(:access_token ) }
      let!(:questions) { create_list(:question, 2, author: user) }
      let(:question) { questions.first }
      let!(:answers) { create_list(:answer, 3, question: question, author: user) }

      let!(:answer) { answers.first}
      let(:answer_response) {json['answer'] }
      let!(:comments_answer) { create_list(:comment, 2, commentable: answer, author: user) }

      let!(:url){'https://gist.github.com/cyberriver/b3373d10e9723eb90211e920d2d4204b'}
      let!(:links_answer) { create_list(:link, 3, linkable: answer, url: url) }
     

      context 'request for answer data' do
        before do
          answer.files.attach(
            io: File.open("#{Rails.root}/spec/rails_helper.rb"),
            filename: 'rails_helper.rb',
            content_type: 'application/rb'
          )

          answer.files.attach(
            io: File.open("#{Rails.root}/spec/spec_helper.rb"),
            filename: 'spec_helper.rb',
            content_type: 'application/rb'
          )
          get base_uri+"/#{answer.id}", params: { access_token: access_token.token }, headers: headers 
        end        

        let(:comment_response) { answer_response['comments'].first }

        it 'returns all public answer data for requested question' do 
          %w[title author_id created_at updated_at].each do |attr|
            expect(answer_response[attr]).to eq answer.send(attr).as_json
          end
        end
        
        it 'returns list of comments' do
          expect(answer_response['comments'].size).to eq comments_answer.count
        end

        it 'returns all public comment data for requested answer' do
          %w[title author_id created_at updated_at].each do |attr|
            expect(comment_response[attr]).to eq comments_answer.first.send(attr).as_json
          end
        end

        it 'returns the list of files' do
          expect(answer_response['files'].size).to eq answer.files.count
        end

        it 'returns the  public file data: file full path' do
          expect(answer_response['files'].first).to eq rails_blob_path( answer.files.first, only_path: true)
        end

        it 'returns the list of links' do
          expect(answer_response['links'].size).to eq answer.links.count
        end
      end 
    end    
  end
end