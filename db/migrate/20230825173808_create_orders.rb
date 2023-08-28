class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :cart, null: false, foreign_key: true
      t.decimal :shipping, default: 0
      t.decimal :discounts, default: 0
      t.decimal :subtotal, default: 0
      t.timestamps
    end
  end
end
