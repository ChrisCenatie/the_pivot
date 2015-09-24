require 'rails_helper'

RSpec.describe Order, type: :model do
  before(:each) do
    Order.delete_all
    User.delete_all
  end

  let(:user) { User.create(email: "justin@example.com", password: "password") }
  let(:order) { Order.new(user_id: user.id) }

  it "is valid" do
    expect(order).to be_valid
  end

  it "is invalid without an associated user" do
    order.user_id = nil
    expect(order).to be_invalid
  end
end
