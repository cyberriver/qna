class Question < ApplicationRecord
  include ResourceLikable

  has_many :answers, dependent: :destroy
  has_many :links, dependent: :destroy, as: :linkable
  has_one :reward, dependent: :destroy
  

  belongs_to :author, class_name: 'User'
  belongs_to :best_answer, class_name: 'Answer', optional: true

  has_many_attached :files, dependent: :detach

  accepts_nested_attributes_for :links, 
                                      allow_destroy: true, 
                                      reject_if: :all_blank
  
  accepts_nested_attributes_for :reward, reject_if: :all_blank
   
  validates :title, :body, presence: true

end
