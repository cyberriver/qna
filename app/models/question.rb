class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true
  scope :order_by_best_answer, ->(question){ question.best_answer.nil? ? order(id: :asc) : (question.best_answer.id).order(id: :asc)} 
   
  validates :title, :body, presence: true

end
