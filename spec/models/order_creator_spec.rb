require "rails_helper"

RSpec.describe OrderCreator do

  it "assigns a user id to an order" do
    order = user.orders.create

    expect(order.user_id).to eq(user.id)
  end

  it "can calculate total price" do
    order_creator = OrderCreator.new( { item1.id => 2, item2.id => 3}, user)
    result = order_creator.total_price

    expect(result).to eq(2750)
  end

end
