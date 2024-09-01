class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.bigint :source_wallet_id
      t.bigint :target_wallet_id
      t.decimal :amount, precision: 15, scale: 2
      t.text :description
      t.timestamps
    end
  end
end
