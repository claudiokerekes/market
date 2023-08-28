module Rules
  class AccessoriesDiscount < Rules::DiscountStrategy
    def initialize(percentage)
      @percentage = percentage
    end

    def apply_discount(order)
      accessories_products = order.order_products.includes(:product)
                                  .where("products.category = :category", category: "Accessories")
      accessories_total = accessories_products.sum(:subtotal)

      if accessories_total > 70
        order.update!(discounts: @percentage)
      end
    end
  end
end