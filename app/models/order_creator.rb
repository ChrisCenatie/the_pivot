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

end
