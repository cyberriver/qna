class LinkSerializer < ActiveModel::Serializer
  attributes :id, :name, :url, :created_at, :updated_at
  belongs_to :linkable, polymorphic: true
end
