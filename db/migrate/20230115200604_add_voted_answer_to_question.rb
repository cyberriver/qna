class AddVotedAnswerToQuestion < ActiveRecord::Migration[6.1]
  def change
    add_reference :questions, :voted_answer, null: true, foreign_key: { to_table: :answers }
  end

end
