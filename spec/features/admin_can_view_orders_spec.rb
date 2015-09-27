require "rails_helper"

RSpec.feature "admin can view orders" do
  before(:each) do
    User.create(email: "admin@example.com", password: "password", role: 3)
    user = User.create(email: "david@example.com", password: "password")
   item = Item.create(name: "Soda", description: "Teh bubbles", price:4)
    @order1 = Order.create(user_id: user.id, status: 0)
    @order2 = Order.create(user_id: user.id, status: 1)
    OrderItem.create(order_id: @order1.id, quantity: 3, price: 4, item_id: item.id)
    OrderItem.create(order_id: @order2.id, quantity: 15, price: 9, item_id: 400)
  end

  scenario "when they go to the dashboard" do
    visit root_path
    click_on("Login")
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(current_path).to eq(admin_dashboard_path)
    expect(page).to have_content("Order ID: #{@order1.id}")
    expect(page).to have_content("Order ID: #{@order2.id}")
    expect(page).to have_content("Ordered: 1")
    expect(page).to have_content("Paid: 1")
    expect(page).to have_content("$12.00")
    expect(page).to have_content("$135.00")

    click_on("Order ID: #{@order1.id}")
    expect(current_path).to eq(order_path(@order1))
  end

end
