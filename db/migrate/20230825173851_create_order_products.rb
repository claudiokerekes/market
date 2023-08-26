class CreateOrderProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :order_products do |t|
      t.references :product, null: false, foreign_key: true
      t.decimal :discount, default: 0
      t.integer :quantity, default: 0
      t.decimal :subtotal, default: 0
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
