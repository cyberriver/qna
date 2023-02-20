class CreateLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :likes do |t|
      t.integer :value, default: 0
      t.belongs_to :user, foreign_key: true
      t.belongs_to :likable, polymorphic: true

      t.timestamps
    end
  end
end
