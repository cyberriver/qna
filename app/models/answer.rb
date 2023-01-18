class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  scope :sort_by_best, -> { order(best: :desc) }

  
  validates :title, presence: true

  def make_vote
    Answer.where(question: self.question, voted: true).update(voted:false)
    self.update(voted:true)
  end

end
