json.orders @orders do |order|
  json.id order.id
  json.total order.total
  json.shipping order.shipping
  json.order_products order.order_products do |order_product|
    json.partial! 'order_product', order_product: order_product
  end
end