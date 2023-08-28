class OrdersService
  SHIPPING_VALUE = 30.freeze # could be an ENV var or data configuration instead
  def initialize(cart)
    @cart = cart
  end

  def create
    ActiveRecord::Base.transaction do
      new_order = create_order
      apply_discount_rules(new_order)
      finish_cart
      new_order
    end
  end

  private
  attr_reader :cart

  def create_order
    order = cart.build_order
    order.user  = cart.user
    cart.cart_products.each do |cart_product|
      order.order_products.build(
        product: cart_product.product,
        product_price:  cart_product.product.price,
        quantity: cart_product.quantity,
        subtotal: cart_product.product.price * cart_product.quantity
      )
    end
    order.shipping = SHIPPING_VALUE
    order.save!
    order.update_total_from_subtotals
    order
  end

  def apply_discount_rules(order)
    ::Rules::AccessoriesDiscount.new(0.1).apply_discount(order)
    ::Rules::ExtraCoffeeDiscount.new.apply_discount(order)
    ::Rules::ShippingDiscount.new.apply_discount(order)
  end

  def finish_cart
    cart.update(finished: true)
  end
end
