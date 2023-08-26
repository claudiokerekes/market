class OrdersService
  def initialize(cart)
    @cart = cart
  end

  def create
    new_order = cart.build_order
    new_order.user  = cart.user
    cart.cart_products.each do |cart_product|
      new_order.order_products.build(
        product: cart_product.product
      )
    end
    new_order.save!
    new_order
  end

  private
  attr_reader :cart
end
