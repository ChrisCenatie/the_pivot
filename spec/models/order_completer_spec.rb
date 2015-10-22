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

  describe "#create_farmer_orders" do
    it "populates the farmer orders table with farmer orders" do
      order = user.orders.create(status: 0)

      cart_data = { item1.id => 3, item2.id => 2 }
      cart = Cart.new(cart_data)
      completer = OrderCompleter.new(order, cart)
      completer.create_order_items
      completer.create_farmer_orders

      expect(FarmerOrder.count).to eq(2)
      expect(FarmerOrder.first.farmer_id).to eq(farmer2.id)
      expect(FarmerOrder.last.farmer_id).to eq(farmer.id)
      expect(FarmerOrder.first.order_id).to eq(Order.last.id)
      expect(FarmerOrder.last.order_id).to eq(Order.last.id)
    end
  end

  describe "#process_farmer_orders" do
    it "populates the farmers orders table and items orders tables" do
      order = user.orders.create(status: 0)

      cart_data = { item1.id => 3, item2.id => 2 }
      cart = Cart.new(cart_data)
      completer = OrderCompleter.new(order, cart)
      completer.process_order

      expect(FarmerOrder.count).to eq(2)
      expect(FarmerOrder.first.farmer_id).to eq(farmer2.id)
      expect(FarmerOrder.last.farmer_id).to eq(farmer.id)
      expect(FarmerOrder.first.order_id).to eq(Order.last.id)
      expect(FarmerOrder.last.order_id).to eq(Order.last.id)
    end
  end
end
