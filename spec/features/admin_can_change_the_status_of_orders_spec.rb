require "rails_helper"

RSpec.feature "admin can change the status of orders" do
  before(:each) do
    User.create(email: "admin@example.com", password: "password", role: 3)
    user = User.create(email: "david@example.com", password: "password")
    category = Category.create(name: "Meals")
    item = Item.create(category_id: category.id, name: "Soda", description: "Teh bubbles", price:4)
    @order1 = Order.create(user_id: user.id, status: 0)
    @order2 = Order.create(user_id: user.id, status: 1)
    OrderItem.create(order_id: @order1.id, quantity: 3, price: 4, item_id: item.id)
    OrderItem.create(order_id: @order2.id, quantity: 15, price: 4, item_id: item.id)
  end

  scenario "when they go to the dashboard" do
    visit root_path
    click_on("Login")
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(page).to have_link("Ordered: 1")
    expect(page).to have_link("Paid: 1")

    within(:css, "div#order_#{@order1.id}") do
      click_on("Mark as paid")
    end

    expect(page).to_not have_link("Ordered: 1")
    expect(page).to have_link("Paid: 2")

    within(:css, "div#order_#{@order2.id}") do
      click_on("Mark as completed")
    end

    expect(page).to have_link("Paid: 1")
    expect(page).to have_link("Completed: 1")

    within(:css, "div#order_#{@order1.id}") do
      click_on("Cancel")
    end

    expect(page).to_not have_link("Paid: 1")
    expect(page).to have_link("Cancelled: 1")

  end
end
