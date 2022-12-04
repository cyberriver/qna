class RemoveTestIdFromQuestions < ActiveRecord::Migration[6.1]
  def change
    remove_column :questions, :test_id
  end
end
