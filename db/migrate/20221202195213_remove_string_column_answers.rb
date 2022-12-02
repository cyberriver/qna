class RemoveStringColumnAnswers < ActiveRecord::Migration[6.1]
  def change
    remove_column(:answers, :string)
  end
end
