require "rails_helper"

RSpec.feature "user can view completed order" do

  before(:each) do
    create_user!
    create_order!
  end

  scenario "after clicking checkout and then logging in" do
    order = Order.last
    expect(current_path).to eq(order_path(order))
  end

  scenario "show page, after completing the order and looking at all of their past orders" do
    click_on("Past orders")
    expect(current_path).to eq(orders_path)

    order = Order.last

    click_on("Order #{order.id}")
    expect(current_path).to eq(order_path(order))

    expect(page).to have_content("Fries")
    expect(page).to have_content("2")
    expect(page).to have_content("$8.00")
    expect(page).to have_content("Ordered")
    expect(page).to have_content("$9.00")
    expect(page).to have_content("#{order.date}")

    click_on("Fries")
    expect(current_path).to eq(category_item_path(@category, Item.find_by(name: "Fries")))
  end

  scenario "and cart is empied after checking out" do
    click_on "Cart"

    expect(page).to_not have_content("Fries")
    expect(page).to_not have_content("Burger")
  end
end
