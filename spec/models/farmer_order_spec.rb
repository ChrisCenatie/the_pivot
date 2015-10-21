require 'rails_helper'

RSpec.describe FarmerOrder, type: :model do
  let(:farmer_order) { FarmerOrder.new(order_id: 1, farmer_id: 1) }

  it "is valid" do
    expect(farmer_order).to be_valid
  end

  it "is invalid without a user id" do
    farmer_order.order_id = nil
    expect(farmer_order).to be_invalid
  end

  it "is invalid wihtout a farmer id" do
    farmer_order.farmer_id = nil
    expect(farmer_order).to be_invalid
  end
end
