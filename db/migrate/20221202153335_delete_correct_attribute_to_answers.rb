class DeleteCorrectAttributeToAnswers < ActiveRecord::Migration[6.1]
  def change
    remove_columns(:answers, :correct)
  end
end
