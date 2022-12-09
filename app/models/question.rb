class Question < ApplicationRecord
  has_many :answers
  belongs_to :author, class_name: 'User'
   
  validates :title, :body, presence: true
end
