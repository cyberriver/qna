class AnswerSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :title, :created_at, :updated_at, :author_id, :short_title, :files
  belongs_to :author, class_name: 'User'
  belongs_to :question
  has_many :comments, as: :commentable, serializer: CommentSerializer
  has_many :links, as: :linkable, serializer: LinkSerializer
  
  def short_title
    object.title.truncate(7)
  end

  def files
    object.files.map { |file| rails_blob_path(file, only_path: true) }
  end
end
