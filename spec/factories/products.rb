FactoryBot.define do
  factory :product do
    name      { Faker::Commerce.product_name }
    category  { Faker::Commerce.department }
    price     { Faker::Commerce.price(range: 0..100.0, as_string: true) }
  end
end
