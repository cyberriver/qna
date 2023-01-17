class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  #belongs_to :voted_answer, class_name: 'Question', optional: true, validate: false
  
  validates :title, presence: true

end
