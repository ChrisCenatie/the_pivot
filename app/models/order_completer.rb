class OrderCompleter
  attr_reader :order, :cart
  def initialize(order, cart)
    @order = order
    @cart = cart
  end

  def process_order
    create_order_items
    delivery_time = calculate_delivery_time
    phone_number = order.user.phone_number
    Notification.new.send_confirmation_message(phone_number, delivery_time)
  end

  def create_order_items
    cart.data.each do |item_id, quantity|
      price = Item.find(item_id).price
      OrderItem.create(order_id: order.id, quantity: quantity, price: price, item_id: item_id)
    end
    empty_cart
  end

  private

  def empty_cart
    @cart = {}
  end
end
