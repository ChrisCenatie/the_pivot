require "rails_helper"

RSpec.describe OrderItem do

  it "has valid attributes" do
    order_item = OrderItem.new(order_id: order.id,
                               item_id: item.id,
                               quantity: 2,
                               price: 400)

    expect(order_item).to be_valid
  end

  it "is invalid without an order id" do
    order_item = OrderItem.new(item_id: item.id,
                               quantity: 2,
                               price: 400)

    expect(order_item).to be_invalid
  end

  it "is invalid without an item id" do
    order_item = OrderItem.new(order_id: order.id,
                               quantity: 2,
                               price: 400)

    expect(order_item).to be_invalid
  end

  it "is invalid without a quantity" do
    order_item = OrderItem.new(order_id: order.id,
                               item_id: item.id,
                               price: 400)

    expect(order_item).to be_invalid
  end

  it "is invalid without a price" do
    order_item = OrderItem.new(order_id: order.id,
                               item_id: item.id,
                               quantity: 2)

    expect(order_item).to be_invalid
  end
end
