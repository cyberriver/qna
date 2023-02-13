class AddRewardToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :reward, :bigint, null: true    
  end
end
