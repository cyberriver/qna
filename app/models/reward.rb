class Reward < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true
  
  has_one_attached :file

  validates :title, presence: true
end
