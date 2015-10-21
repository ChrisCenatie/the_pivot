class OrderCompleter
  attr_reader :order, :cart
  def initialize(order, cart)
    @order = order
    @cart = cart
  end

  def process_order
    create_order_items
    create_farmer_orders
    order.update(status: 1)
    delivery_time = "soon"
    if ENV["RAILS_ENV"] != "test"
      delivery_time = DeliveryTime.new(order).time
    end
    if !@order.user.phone_number.blank?
      phone_number = order.user.phone_number
      Notification.new.send_confirmation_message(phone_number, delivery_time)
      order.update(notification: 1)
    end
  end

  def create_order_items
    cart.data.each do |item_id, quantity|
      price = Item.find(item_id).price
      OrderItem.create(order_id: order.id,
                       quantity: quantity,
                       price:    price,
                       item_id:  item_id)
    end
    empty_cart
  end

  def create_farmer_orders
    items = @order.items
    items.each do |item|
      farmer_id = item.farmer.id
      FarmerOrder.create(order_id: order.id, farmer_id: farmer_id)
    end
  end

  private

  def empty_cart
    @cart = {}
  end
end
