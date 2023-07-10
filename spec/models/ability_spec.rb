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

    it { should be_able_to :update, user_question }
    it { should_not be_able_to :update, other_user_question }

    it { should be_able_to :update, user_answer }
    it { should_not be_able_to :update, other_user_answer }
    
    it { should be_able_to :update, create(:comment, commentable: user_answer, author: user) }
    it { should_not be_able_to :update, create(:comment, commentable: user_answer, author: other) }

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
    it { should be_able_to :destroy, create(:link, linkable: user_question,  url: gist_url, name: 'My gist user') }
    it { should_not be_able_to :destroy, create(:link, linkable: other_user_question, url: gist_url, name: 'My gist other') }

    # likes
    it { should be_able_to :like, other_user_question, author: other }
    it { should_not be_able_to :like, user_question, author: user }

    # dislikes
    it { should be_able_to :dislike, other_user_question, author: other }
    it { should_not be_able_to :dislike, user_question, author: user }

    # Rewards
    it { should be_able_to :read, :all }

  end
end