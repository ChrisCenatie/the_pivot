class Cart
  include ActionView::Helpers::NumberHelper
  attr_reader :cart_data

  def initialize(cart_data = {})
    @cart_data = cart_data || {}
  end

  def total_price
    price = items.reduce(0) do |sum, cart_item|
      sum += cart_item.price * cart_item.quantity
    end
    number_to_currency(price)
  end

  def add_item(item_id)
    cart_data[item_id.to_s] = cart_data[item_id.to_s].to_i + 1
  end

  def remove_item(item_id)
    if (cart_data[item_id.to_s] - 1) < 1
      cart_data.delete_if { |k, _| k == item_id.to_s }
    else
      cart_data[item_id.to_s] = cart_data[item_id.to_s].to_i - 1
    end
  end

  def items
    cart_data.map do |item_id, quantity|
      item = Item.find(item_id)
      CartItem.new(item, quantity)
    end
  end

  def data
    cart_data
  end
end
