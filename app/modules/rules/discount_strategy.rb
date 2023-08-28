module Rules
  class DiscountStrategy
    def apply_discount(order)
      raise NotImplementedError, "Subclasses must implement this method"
    end
  end
end