class Comment < ApplicationRecord
  belongs_to :commentable, polymorphic: true, touch: true
  belongs_to :author, class_name: 'User'

  validates :title,  presence: true
end
