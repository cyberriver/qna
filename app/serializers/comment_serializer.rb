class CommentSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :updated_at, :author_id
  belongs_to :commentable, polymorphic: true
end
