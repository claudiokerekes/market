module Api
  module V1
    class OrdersController < CartsController

      def index
        @orders ||= user.orders
      end
      def create
        @order = OrdersService.new(cart).create
      end

      private

    end
  end
end
