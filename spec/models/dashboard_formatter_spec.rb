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

  it "figures out the correct link(s) for an order to show" do
    ordered_links = DashboardFormatter.new(Order.where(status: 0).take).find_links
    paid_links = DashboardFormatter.new(Order.where(status: 1).take).find_links
    cancelled_links = DashboardFormatter.new(Order.where(status: 2).take).find_links
    completed_links = DashboardFormatter.new(Order.where(status: 3).take).find_links

    expect(ordered_links).to eq({"Cancel" => "cancelled", "Mark as paid" => "paid" })
    expect(paid_links).to eq({"Cancel" => "cancelled", "Mark as completed" => "completed" })
    expect(cancelled_links).to eq({})
    expect(completed_links).to eq({})
  end
end
