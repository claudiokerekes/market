json.orders @orders do |order|
  json.id order.id
  json.subtotal order.subtotal
  json.discounts number_to_percentage(order.discounts * 100, precision: 0)
  json.total  order.subtotal * (1- order.discounts)
  json.shipping order.shipping
  json.order_products order.order_products do |order_product|
    json.partial! 'order_product', order_product: order_product
  end
end