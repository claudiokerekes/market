require 'rails_helper'

RSpec.describe "List Cart Orders", type: :request do

  subject {  get api_v1_carts_path , headers: headers, as: :json }

  let(:headers) { {HTTP_USER_ID: user.id}  }
  let(:user)    { create(:user) }

  it "returns http success" do
    subject
    expect(response).to have_http_status(:success)
  end

  context "when the user has a empty cart" do
    it "returns an empty array" do
      subject
      expect(json).to eq []
    end
  end

  context "when user have added products in the cart" do
    let(:cart) { create(:cart, :with_cart_products, user: user) }
    let!(:cart_products_ids) { cart.cart_products.pluck(:id) }

    it "returns cart products array" do
      subject
      json_array_ids = json.map { |item| item["id"] }
      expect(json_array_ids).to match_array cart_products_ids
    end
  end



end
