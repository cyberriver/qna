class AddConfirmationToAuthorization < ActiveRecord::Migration[6.1]
  def change
    add_column :authorizations, :confirmed, :boolean, null: false, default: false
  end
end
