module Rules
  class ExtraCoffeeDiscount < Rules::DiscountStrategy
    def apply_discount(order)
      purchased_coffees = order.order_products.joins(:product)
                               .where("products.category = :category", category: "Coffee")
      coffee_count = purchased_coffees.sum(:quantity)
      if coffee_count >= 2
        extra_coffee =  purchased_coffees.first.dup # assumption to get the first coffee product and
        # duplicate it in the order
        extra_coffee.quantity = 1
        extra_coffee.save
      end
    end
  end
end