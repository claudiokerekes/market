module Rules
  class ShippingDiscount < Rules::DiscountStrategy
    def apply_discount(order)
      equipment_count = order.order_products.joins(:product)
                             .where("products.category = :category", category: "Equipment").sum(:quantity)
      if equipment_count >= 3
        order.update(shipping: 0)
      end
    end
  end
end