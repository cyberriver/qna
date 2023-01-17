class Question < ApplicationRecord
  has_many :answers, dependent: :destroy
  belongs_to :author, class_name: 'User'
  has_one :voted_answer, class_name: 'Answer', validate: false
  accepts_nested_attributes_for :voted_answer, update_only: true, allow_destroy: false

   
  validates :title, :body, presence: true




end
