ThinkingSphinx::Index.define :answer, with: :active_record do
  indexes title

  #attributes
  has author_id, created_at, updated_at
end