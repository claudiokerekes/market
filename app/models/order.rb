class Order < ApplicationRecord
  belongs_to :cart
  belongs_to :user
  has_many :order_products

  accepts_nested_attributes_for :order_products
end
