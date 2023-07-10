class Answer < ApplicationRecord
  include ResourceLikable

  belongs_to :question
  belongs_to :author, class_name: 'User'
  has_many :links, dependent: :destroy, as: :linkable  
  has_many :comments, dependent: :destroy, as: :commentable  

  has_many_attached :files, dependent: :detach

  accepts_nested_attributes_for :links, 
                                        allow_destroy: true,
                                        reject_if: :all_blank
  
  validates :title, presence: true

  after_create :new_answer_notice

  def voted?(resource)
    resource.best_answer_id == self.id   
  end
  
  def new_answer_notice
    NewAnswerNotifyJob.perform_later(self)
  end

end
