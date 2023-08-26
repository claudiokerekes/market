class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :cart, null: false, foreign_key: true
      t.decimal :shipping, default: 0
      t.decimal :total, default: 0
      t.timestamps
    end
  end
end
