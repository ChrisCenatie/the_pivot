require "rails_helper"

RSpec.describe OrderCreator do

  let(:user) { User.create(email: "justin@example.com", password: "password") }

  it "assigns a user id to an order" do
    order = user.orders.create

    expect(order.user_id).to eq(user.id)
  end

end
