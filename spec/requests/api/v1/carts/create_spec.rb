require 'rails_helper'

RSpec.describe "Create Cart Product", type: :request do

  subject {  post api_v1_carts_path ,params: params,  headers: headers, as: :json }

  let(:headers) { {HTTP_USER_ID: user.id}  }
  let(:user)    { create(:user) }
  let(:product) { create(:product) }
  let(:quantity) { rand(1..10) }
  let(:params) do
    {
      cart_product:{
        product_id: product.id,
        quantity: quantity
      }
    }
  end

  it "returns http success" do
    subject
    expect(response).to have_http_status(:success)
  end

  context "when the user creates a new cart product" do
    let(:cart) { create(:cart, user: user) }
    let(:json_expected) do
      {
        "quantity"=> quantity,
        "product_name"=> product.name,
        "product_price"=> product.price.to_f.to_s,
        "product_category"=> product.category
      }
    end

    it "returns the cart product created" do
      subject
      json_expected = json.delete("id")
      expect(json_expected).to eq json_expected
    end
  end
end
