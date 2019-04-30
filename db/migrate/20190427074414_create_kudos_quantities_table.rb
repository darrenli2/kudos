class CreateKudosQuantitiesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :kudos_quantities do |t|
      t.references :user
      t.integer :quantity, default: 3, null: false
      t.integer :lock_version, default: 0, null: false
      t.timestamps
    end
  end
end
