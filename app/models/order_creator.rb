class OrderCreator
  attr_reader :cart_data, :user

  def initialize(cart_data, user)
    @cart_data = cart_data
    @user      = user
  end

  def order
    @order ||= user.orders.create
  end

  def total_price
    cart_items = cart_data.map do |item_id, quantity|
      [Item.find(item_id.to_i).price, quantity.to_i]
    end
    cart_items.reduce(0) do |sum, cart_item|
      sum += cart_item[0] * cart_item[1]
    end
  end

  def create_order_items
    cart_data.each do |item_id, quantity|
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
