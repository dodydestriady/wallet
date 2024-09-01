class CreateEntities < ActiveRecord::Migration[7.2]
  def change
    create_table :entities do |t|
      t.string :name
      t.string :entity_type
      t.string :email
      t.string :password_digest
      t.string :access_token
      t.datetime :expiry_token

      t.timestamps
    end
  end
end
