class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  has_one :voted_answer, class_name: :Answer
   
  validates :title, :body, presence: true
end
