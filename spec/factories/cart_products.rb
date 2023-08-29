FactoryBot.define do
  factory :cart_product do
    association :cart
    association :product, factory: :product
    quantity { rand(1..10) }
  end
end
