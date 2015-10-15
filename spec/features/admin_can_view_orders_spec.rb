require "rails_helper"

RSpec.feature "admin can view orders" do
  before(:each) do
    Address.create(user_id: user.id,
                   street_address: "1510 Blake street",
                   apt: "basement",
                   city: "Denver",
                   state: "CO",
                   zip_code: "80110")

    item = Item.create(category_id: category.id,
                       name: "Soda",
                       description: "Teh bubbles",
                       price:4,
                       farmer_id: farmer.id)

    item2 = Item.create(category_id: category.id,
                        name: "Cake",
                        description: "Its good",
                        price: 7,
                        farmer_id: farmer.id)

    @order1 = Order.create(user_id: user.id,
                           status: 0)
    @order2 = Order.create(user_id: user.id,
                           status: 1)
    @order3 = Order.create(user_id: user2.id,
                           status: 2)
    @order4 = Order.create(user_id: user2.id,
                           status: 3)

    OrderItem.create(order_id: @order1.id,
                     quantity: 3,
                     price: 4,
                     item_id: item.id)

    OrderItem.create(order_id: @order2.id,
                     quantity: 15,
                     price: 4,
                     item_id: item.id)

    OrderItem.create(order_id: @order3.id,
                     quantity: 4,
                     price: 7,
                     item_id: item2.id)

    OrderItem.create(order_id: @order4.id,
                     quantity: 25,
                     price: 7,
                     item_id: item2.id)
  end

  scenario "when they go to the dashboard" do
    login_admin!

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Order ID: #{@order1.id}")
    expect(page).to have_content("Order ID: #{@order2.id}")
    expect(page).to have_link("Ordered: 1")
    expect(page).to have_link("Paid: 1")
    expect(page).to have_content("$12.00")
    expect(page).to have_content("$175.00")

    click_link("Ordered: #{Order.ordered.count}")

    expect(page).to_not have_content("Order ID: #{@order2.id}")

    click_on("Order ID: #{@order1.id}")

    expect(current_path).to eq(order_path(@order1))
    expect(page).to have_link("Dashboard")
  end
end
