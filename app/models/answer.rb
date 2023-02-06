class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :author, class_name: 'User'
  has_many :links, dependent: :destroy, as: :linkable

  has_many_attached :files, dependent: :detach

  accepts_nested_attributes_for :links, 
                                        allow_destroy: true,
                                        reject_if: :all_blank
  
  validates :title, presence: true

  def voted?(resource)
    resource.best_answer_id == self.id   
  end

end
