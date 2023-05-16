class QuestionSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  
  attributes :id, :title, :body, :created_at, :updated_at, :author_id, :short_title, :files
  has_many :answers
  belongs_to :author, class_name: 'User'
  has_many :comments, as: :commentable, serializer: CommentSerializer
  
  def short_title
    object.title.truncate(7)
  end

  def files
    object.files.map { |file| rails_blob_path(file, only_path: true) }
  end
end
