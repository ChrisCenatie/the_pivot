class Cart
  attr_reader :cart_data

  def initialize(cart_data = {})
    @cart_data = cart_data || {}
  end

  def add_item(item_id)
    item = Item.find(item_id)
    cart_data[item.id.to_s] = cart_data[item.id.to_s].to_i + 1
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