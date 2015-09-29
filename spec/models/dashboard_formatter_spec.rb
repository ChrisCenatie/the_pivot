require "rails_helper"

RSpec.describe DashboardFormatter do
  before(:each) do
    10.times do |n|
      user = User.create(email: "sample#{n}@example.com", password: "password")
      user.orders.create
      user.orders.create(status: 1)
      user.orders.create(status: 2)
      user.orders.create(status: 3)
    end
  end

  it "calculates the number of each order by its status" do
    expect(DashboardFormatter.ordered?).to eq(10)
    expect(DashboardFormatter.paid?).to eq(10)
    expect(DashboardFormatter.cancelled?).to eq(10)
    expect(DashboardFormatter.completed?).to eq(10)
  end
end
