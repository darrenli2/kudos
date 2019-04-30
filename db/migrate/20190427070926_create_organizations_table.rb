class CreateOrganizationsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :organizations do |t|
      t.string :name, limit: 100
      t.timestamps
    end
  end
end
