module Api
    module V1
      class CartsController < ApplicationController
        before_action :user, :cart
        before_action :cart_product, only: [:update, :destroy]

        def index
          @cart_products = cart.cart_products
        end

        def create
          @cart_product = cart.cart_products.build(cart_product_params)
          @cart_product.save
          @cart_product
        end

        def update
          cart_product.update!(cart_product_params)
          @cart_product = cart_product
        end

        def destroy
          cart_product.destroy!
        end

        private

        def cart_product_params
          params.require(:cart_product).permit(:product_id, :quantity)
        end

        def cart_product
          CartProduct.find(params[:id])
        end

        def cart
         @cart ||= Cart.find_or_create_by!(user_id: user.id)
        end

        def user
          # a simply method to identify the request user
          @user ||= User.find(request.headers["HTTP_USER_ID"])
        end
      end
    end
end