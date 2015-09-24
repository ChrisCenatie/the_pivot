require "rails_helper"

RSpec.feature "user can view past orders" do

  before(:each) do
    category = Category.create(name: "Meals")
    Item.create(category_id: category.id, name: "Burger",
        description: "For a rabbi", price: 200)
    Item.create(category_id: category.id, name: "Steak",
        description: "Fo Free", price: 400)

    @user = User.create(email: "david@example.com", password: "password")
    mike = User.create(email: "mike@example.com", password: "password")
    mike.orders.create
  end

  scenario "when they visit /orders" do
    visit login_path
    fill_in("Email", with: "david@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
    visit items_path
    click_on("Add Steak")
    click_on("Cart")
    click_on("Check Out")

    order = Order.last
    expect(current_path).to eq(order_path(order))
    visit orders_path

    expect(page).to have_content("Steak")
    expect(current_path).to eq(orders_path)
    expect(@user.orders.count).to eq(1)
  end

  xscenario "for only their own cart" do

        visit items_path
        click_on("Meals")
        click_on("Add Burger")
        click_on("Cart")
        click_on("Check Out")

        expect(page).to have_content("Burger 1 200")
        expect(user.orders.count).to eq(2)

        visit orders_path

        expect(page).to have_content("Burger")
        expect(page).to have_content("Steak")
  end
end
