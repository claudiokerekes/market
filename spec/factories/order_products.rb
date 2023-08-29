FactoryBot.define do
  factory :order_product do
    product  { create(:product) }
    quantity { rand(1..10) }
    product_price { product.price }
    order
  end
end
