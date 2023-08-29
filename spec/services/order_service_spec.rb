# frozen_string_literal: true

require 'rails_helper'
describe OrdersService do
  subject { described_class.new(cart).create }

  context "when we call the create method" do
    let(:cart) { create(:cart, :with_cart_products) }
    it "order is created" do
      expect{subject}.to change(Order.all, :count).by(1)
    end
  end

  ## TESTING RULE DISCOUNTS

  context "when the cart has more than 70 dollars in Accessories category" do
    let(:product) { create(:product, price: 71, category: "Accessories") }
    let(:cart) { create(:cart) }
    let!(:cart_products) { create(:cart_product, product: product, cart: cart) }

    it "the order discounts is 10%" do
      subject
      last_order = Order.last
      expect(last_order.discounts).to eq 0.1
    end
  end


  context "when the cart has two or more coffee category products" do
    let(:product_coffee) { create(:product, price: 10, category: "Coffee") }
    let(:cart) { create(:cart) }
    let!(:cart_products) { create(:cart_product, product: product_coffee, cart: cart, quantity: 2) }

    it "a extra coffee is added into the order" do
      order = subject
      purchased_coffees = order.order_products.joins(:product)
                               .where("products.category = :category", category: "Coffee").sum(:quantity)

      expect(purchased_coffees).to eq 3
    end
  end

  context "when the cart has less than two coffee category products" do
    let(:product_coffee) { create(:product, price: 10, category: "Coffee") }
    let(:cart) { create(:cart) }
    let!(:cart_products) { create(:cart_product, product: product_coffee, cart: cart, quantity: 1) }

    it "a extra coffee is not added into the order" do
      order = subject
      purchased_coffees = order.order_products.joins(:product)
                               .where("products.category = :category", category: "Coffee").sum(:quantity)

      expect(purchased_coffees).to eq 1
    end
  end

  context "when the cart has three or more Equipment category products" do
    let(:product_equipment_1) { create(:product, price: 10, category: "Equipment") }
    let(:product_equipment_2) { create(:product, price: 12, category: "Equipment") }
    let(:cart) { create(:cart) }
    let!(:cart_products_1) { create(:cart_product, product: product_equipment_1, cart: cart, quantity: 2) }
    let!(:cart_products_2) { create(:cart_product, product: product_equipment_2, cart: cart, quantity: 1) }

    it "the order shipping value is 0" do
      expect(subject.shipping.to_f).to eq 0
    end
  end

  context "when the cart has less than three Equipment category products" do
    let(:product_equipment_1) { create(:product, price: 10, category: "Equipment") }
    let(:product_equipment_2) { create(:product, price: 12, category: "Equipment") }
    let(:cart) { create(:cart) }
    let!(:cart_products) { create(:cart_product, product: product_equipment_1, cart: cart, quantity: 2) }
    let!(:cart_products) { create(:cart_product, product: product_equipment_2, cart: cart, quantity: 1) }

    it "the order shipping value is 30" do
      expect(subject.shipping).to eq 30
    end
  end

end