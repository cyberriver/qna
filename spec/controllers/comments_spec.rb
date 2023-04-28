require 'rails_helper'
Rails.application.config.middleware.insert_before Warden::Manager, ActionDispatch::Cookies
Rails.application.config.middleware.insert_before Warden::Manager, ActionDispatch::Session::CookieStore


RSpec.describe CommentsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answer) { create(:answer, question: question, user: user) }
  let(:comment) { create(:comment, commentable: question, user: user) }
  let(:comment) { create(:comment, commentable: answer, user: user) }

  describe 'POST #create' do
    context 'with filled comment title' do
      before { login(user) }
      it 'saves a new comment for questionb' do
        expect { post :create, params: { question_id: question, comment: attributes_for(:comment) }, format: :js }.to change(question.comments, :count).by(1)
        expect { post :create, params: { question_id: question, comment: attributes_for(:comment) }, format: :js }.to change(user.comments, :count).by(1)
        expect { post :create, params: { answer_id: answer, comment: attributes_for(:comment) }, format: :js }.to change(answer.comments, :count).by(1)
        expect { post :create, params: { answer_id: answer, comment: attributes_for(:comment) }, format: :js }.to change(user.comments, :count).by(1)
      end

      it 'render create template' do
        post :create, params: { question_id: question, comment: attributes_for(:comment) }, format: :js
        expect(response).to render_template :create
        post :create, params: { answer_id: answer, comment: attributes_for(:comment) }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'with empty title' do
      before { login(user) }
      it 'does not save the comment in to db' do
        expect { post :create, params: { question_id: question, comment: attributes_for(:comment, :invalid) }, format: :js }.to_not change(question.comments, :count)
        expect { post :create, params: { question_id: question, comment: attributes_for(:comment, :invalid) }, format: :js }.to_not change(user.comments, :count)
        expect { post :create, params: { answer_id: answer, comment: attributes_for(:comment, :invalid) }, format: :js }.to_not change(answer.comments, :count)
        expect { post :create, params: { answer_id: answer, comment: attributes_for(:comment, :invalid) }, format: :js }.to_not change(user.comments, :count)
      end

      it 'render create template' do
        post :create, params: { question_id: question, comment: attributes_for(:comment, :invalid) }, format: :js
        expect(response).to render_template :create
        post :create, params: { answer_id: answer, comment: attributes_for(:comment, :invalid) }, format: :js
        expect(response).to render_template :create
      end
    end

    context 'guest cant to leave comment' do
      it 'does not save the comment in to db' do
        expect { post :create, params: { question_id: question, comment: attributes_for(:comment) }, format: :js }.to_not change(question.comments, :count)
        expect { post :create, params: { answer_id: answer, comment: attributes_for(:comment) }, format: :js }.to_not change(answer.comments, :count)
      end

      it 'render create template' do
        post :create, params: { question_id: question, comment: attributes_for(:comment) }, format: :js
        post :create, params: { answer_id: answer, comment: attributes_for(:comment) }, format: :js
      end
    end
  end
end