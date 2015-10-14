require "rails_helper"

RSpec.describe OrderCompleter do

  let(:user) { User.create(email: "justin@example.com",
                           password: "password") }
  let(:farmer) { Farmer.create(name: "McDonald") }

  describe "#create_order_items" do
    it "populates the order items table with order items" do
      order = user.orders.create(status: 0)
      item1 = Item.create(name: 'Soda',
                          description: 'Sugary',
                          price: 350,
                          category_id: 1,
                          farmer_id: farmer.id)
      item2 = Item.create(name: 'Fries',
                          description: 'Salty',
                          price: 400,
                          category_id: 1,
                          farmer_id: farmer.id)

      cart_data = { item1.id => 3, item2.id => 2 }
      cart = Cart.new(cart_data)
      completer = OrderCompleter.new(order, cart)
      completer.create_order_items

      expect(completer.order.order_items.last.quantity).to eq(2)
    end
  end
end
