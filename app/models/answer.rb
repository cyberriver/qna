class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'

  
  validates :title, presence: true

  def voted?(resource)
    resource.best_answer_id == self.id   
  end

end
