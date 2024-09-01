class CreateWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :wallets do |t|
      t.references :walletable, polymorphic: true

      t.timestamps
    end
  end
end
