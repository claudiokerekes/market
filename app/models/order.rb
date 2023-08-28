class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user
  has_many :order_products

  accepts_nested_attributes_for :order_products

  def update_total_from_subtotals
    new_total = order_products.sum(:subtotal)
    update(subtotal: new_total)
  end
end
