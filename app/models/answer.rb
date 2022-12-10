class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  
  validates :title, presence: true
end
