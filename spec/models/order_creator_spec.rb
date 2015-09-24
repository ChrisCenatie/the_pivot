require "rails_helper"

RSpec.describe OrderCreator do

  let(:user) { User.create(email: "justin@example.com", password: "password") }

  it "assigns a user id to an order" do
    order = user.orders.create

    expect(order.user_id).to eq(user.id)
  end

  describe "#create_order_items" do
    it "populates the order items table with order items" do
      item1 = Item.create(name: 'Soda', description: 'Sugary', price: 350)
      item2 = Item.create(name: 'Fries', description: 'Salty', price: 400)

      cart_data = { item1.id => 3, item2.id => 2 }

      order_creator = OrderCreator.new(cart_data, user)

      order_creator.create_order_items

      expect(order_creator.order.order_items.last.quantity).to eq(2)
    end
  end
end
