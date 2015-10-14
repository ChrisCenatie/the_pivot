require "rails_helper"

RSpec.feature "user can view past orders" do

  before(:each) do
    create_item!
    create_item1!
    create_item2!
    create_user!
    create_user2!
  end

  scenario "when they visit /orders" do
    create_order!

    order = Order.last
    expect(current_path).to eq(order_path(order))
    visit orders_path

    expect(current_path).to eq(orders_path)
    expect(@user.orders.count).to eq(1)

    visit category_items_path(@category)
    click_on("Add Burger")
    click_on("Cart")
    click_on("Check Out")

    visit orders_path
    order = Order.last
    expect(page).to have_content("Order #{order.id}")
    expect(page).to have_content("#{order.date}")
    expect(page).to have_content("#{order.total_price}")
  end

  scenario "for only their own cart" do
    create_order!
    order1 = Order.last

    click_on("Logout")

    login_user2!

    visit category_items_path(@category)
    click_on("Add Burger")
    click_on("Cart")
    click_on("Check Out")
    input_user_info!
    click_on("Check Out")
    order2 = Order.last

    visit orders_path

    expect(page).to have_content("Order #{order2.id}")
    expect(page).to_not have_content("Order #{order1.id}")
  end

  scenario "only if logged in" do
    visit orders_path
    expect(current_path).to eq(login_path)
  end
end
