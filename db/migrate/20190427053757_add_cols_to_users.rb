class AddColsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string, limit: 50
    add_column :users, :last_name,  :string, limit: 50
    add_reference :users, :organization, foreign_key: true
  end
end
