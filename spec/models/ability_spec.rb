require 'rails_helper'
require "cancan/matchers"

describe Ability, type: :model do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for admin' do
    let(:user) { create :user, admin: true }

    it { should be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:user_question) { create(:question, author: user) }
    let(:other_user_question) { create(:question, author: other) }
    let(:user_answer) { create(:answer, question: other_user_question, author: user) }
    let(:other_user_answer) { create(:answer, question: user_question, author: other) }
    let(:gist_url) { 'https://gist.github.com/cyberriver/b3373d10e9723eb90211e920d2d4204b'}


    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }

    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }
    it { should be_able_to :create, Link }

    it { should be_able_to :update, create(:question, author: user) }
    it { should_not be_able_to :update, create(:question, author: other) }

    it { should be_able_to :update, create(:answer, author: user) }
    it { should_not be_able_to :update, create(:answer, author: other) }
    
    it { should be_able_to :update, create(:comment, commentable: create(:answer, author: user), author: user) }
    it { should_not be_able_to :update, create(:comment, commentable: create(:answer, author: user), author: other) }

    context 'question attachments' do
      before do
        user_question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: 'rails_helper.rb')
        other_user_question.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: 'rails_helper.rb')
      end
      it { should be_able_to :destroy, user_question.files.first, author: user }
      it { should_not be_able_to :destroy, other_user_question.files.first, author: other }
    end

    context 'answer attachments' do
      before do
        user_answer.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: 'rails_helper.rb')
        other_user_answer.files.attach(io: File.open("#{Rails.root}/spec/rails_helper.rb"), filename: 'rails_helper.rb')
      end
      it { should be_able_to :destroy, user_answer.files.first, author: user }
      it { should_not be_able_to :destroy, other_user_answer.files.first, author: other }
    end

    # Links
    it { should be_able_to :destroy, create(:link, linkable: create(:question, author: user), url: gist_url, name: 'My gist') }
    it { should_not be_able_to :destroy, create(:link, linkable: create(:question, author: other), url: gist_url, name: 'My gist') }

    # likes
    it { should be_able_to :like, create(:question, author: other), author: other }
    it { should_not be_able_to :like, create(:question, author: user), author: user }

    # dislikes
    it { should be_able_to :dislike, create(:question, author: other), author: other }
    it { should_not be_able_to :dislike, create(:question, author: user), author: user }

  end
end