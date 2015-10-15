require "rails_helper"

RSpec.describe OrderCompleter do

  describe "#create_order_items" do
    it "populates the order items table with order items" do
      order = user.orders.create(status: 0)

      cart_data = { item1.id => 3, item2.id => 2 }
      cart = Cart.new(cart_data)
      completer = OrderCompleter.new(order, cart)
      completer.create_order_items

      expect(completer.order.order_items.last.quantity).to eq(2)
    end
  end
end
