class AddUserToCart < ActiveRecord::Migration[7.0]
  def change
    add_reference :carts, :user, null: false, foreign_key: true
    add_column :carts, :finished, :boolean, default: false
    add_reference :orders, :user, null: false, foreign_key: true
  end
end
