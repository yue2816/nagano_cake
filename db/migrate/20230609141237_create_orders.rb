class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.string :shipping_postal_code, null: false
      t.string :shipping_address, null: false
      t.string :shipping_name, null: false
      t.integer :payment, null: false
      t.integer :shipping_fee, null: false
      t.integer :amount_billed, null: false
      t.timestamps
    end
  end
end
