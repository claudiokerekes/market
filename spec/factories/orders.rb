FactoryBot.define do
  factory :order do
    cart
    shipping  {  Faker::Commerce.price(range: 0..100.0, as_string: true ) }
    discounts { rand(0.0..1.0) }

    trait :with_product_orders do
      after(:create) do |order|
        create_list(:order_product, 3, order: order)
      end
    end
  end
end
