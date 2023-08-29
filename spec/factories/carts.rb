FactoryBot.define do
  factory :cart do
    association :user, factory: :user
    finished { false }

    trait :with_cart_products do
      after(:create) do |cart|
        create_list(:cart_product, 3, cart: cart)
      end
    end
  end
end
