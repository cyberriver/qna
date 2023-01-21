class AddBestAnswerIdToQuestion < ActiveRecord::Migration[6.1]
  def change    
    add_column :questions, :best_answer_id, :bigint, null: true    
  end
end
