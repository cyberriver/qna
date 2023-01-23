class AddVotedToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :voted, :boolean,  default: false
  end
end
