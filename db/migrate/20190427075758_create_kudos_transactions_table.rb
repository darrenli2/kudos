class CreateKudosTransactionsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :kudos_transactions do |t|
      t.references :giver
      t.references :receiver
      t.integer    :quantity, null: false
      t.string     :message, limit: 1000, null: true
      t.date       :date
      t.timestamps
    end
  end
end
