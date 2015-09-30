require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) {
    user = User.create(email: "david@example.com", password: "password")
    Address.create(user_id: user.id, street_address: "901 Sherman St",
      apt: "", city: "Denver", state: "CO", zip_code: "80203")
    @order = Order.create(user_id: user.id, status: 0)
  }

  it "can get the lat long string" do
    string = DeliveryTime.new(@order).get_lat_lon

    expect(string).to eq("39.730486,-104.985036,901 Sherman St,Denver,CO,80203")
  end

  it "can calculate distance" do
    distance = DeliveryTime.new(@order).distance

    expect(distance).to eq(1.55)
  end

  it "can calculate time" do
    time = DeliveryTime.new(@order).time

    expect(time).to eq(4.33)
  end

  it "can calculate another time" do
    user2 = User.create(email: "justin@example.com", password: "password")
    Address.create(user_id: user2.id, street_address: "2822 W 28th Ave",
      apt: "", city: "Denver", state: "CO", zip_code: "80211")
    order2 = Order.create(user_id: user2.id, status: 0)

    time = DeliveryTime.new(order2).time

    expect(time).to eq(4.1)
  end
end
