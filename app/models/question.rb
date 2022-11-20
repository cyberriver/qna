class Question < ApplicationRecord
  has_many :answers
  belongs_to :test, dependent: :destroy
  
  validates :title, :body, presence: true
end
