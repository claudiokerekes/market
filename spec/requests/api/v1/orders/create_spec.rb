require 'rails_helper'

RSpec.describe "Create Order", type: :request do
  subject {  post api_v1_orders_path, headers: headers, as: :json }

  let(:headers) { {HTTP_USER_ID: user.id}  }
  let(:user)    { create(:user) }
  let(:cart) { create(:cart, :with_cart_products) }
  let(:user) { cart.user }

  it "returns http success" do
    subject
    expect(response).to have_http_status(:success)
  end

  context "when user creates an order" do
    let(:order_expected) do
      {
        "subtotal"=> subtotal.to_f.to_s,
        "order_products"=> order_products
      }
    end

    let(:subtotal) do
      cart.cart_products.sum { |cart_product| cart_product.product.price * cart_product.quantity }
    end

    let(:order_products) do
      order_products = []
      cart.cart_products.each do |cart_product|
        order_product = {
          quantity: cart_product.quantity,
          product_subtotal:  (cart_product.quantity * cart_product.product.price).to_f.to_s,
          product_name: cart_product.product.name,
          product_category: cart_product.product.category
        }.as_json
        order_products << order_product
      end
      order_products
    end

    it "returns the order" do
      subject
      json_data = json.deep_dup.tap do |data|
        data.delete('id')
        data.delete('discount')
        data.delete('total')
        data['order_products'].each { |order_product| order_product.delete('id') }
      end
      #json =  jsoΩn.delete("id")
      #json = json.delete("discount")
      expect(json_data).to eq order_expected
    end
  end
end
