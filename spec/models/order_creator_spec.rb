require "rails_helper"

RSpec.describe OrderCreator do

  let(:user) { User.create(email: "justin@example.com", password: "password") }

  it "assigns a user id to an order" do
    order = user.orders.create

    expect(order.user_id).to eq(user.id)
  end

  it "can calculate total price" do
    item1 = Item.create(name: 'Soda', description: 'Sugary', price: 100, category_id: 1)
    item2 = Item.create(name: 'Burger', description: 'beef', price: 200, category_id: 2)
    order_creator = OrderCreator.new( { item1.id => 2, item2.id => 3}, user)
    result = order_creator.total_price

    expect(result).to eq(800)
  end

end
