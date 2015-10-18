require 'rails_helper'

RSpec.describe Order, type: :model do

  let(:user) { User.create(email: "justin@example.com", password: "password",
    first_name: "Justin", last_name: "Beiber", phone_number: "555-555-5555") }
  let(:order) { Order.new(user_id: user.id) }

  it "is valid" do
    expect(order).to be_valid
  end

  it "is invalid without an associated user" do
    order.user_id = nil
    expect(order).to be_invalid
  end

  it "has a default status of ordered" do
    expect(order.status).to eq("ordered")
  end

  it "has a default notification of unsent" do
    expect(order.notification).to eq("unsent")
  end

  describe "#total_price" do
    it "can calculate its total price" do
      order.save
      order.order_items.create(item_id: 1, quantity: 2, price: 1)
      order.order_items.create(item_id: 2, quantity: 3, price: 2)
      order.order_items.create(item_id: 3, quantity: 4, price: 2)

      result = order.total_price

      expect(result).to eq("$16.00")
    end
  end
end
