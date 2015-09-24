require "rails_helper"

RSpec.feature "user can view past orders" do

  let(:category) { Category.create(name: "Meals") }
  let(:burger) { Item.create(category_id: category.id, name: "Burger",
      description: "For a rabbi", price: 200) }
  let(:steak) { Item.create(category_id: category.id, name: "Steak",
      description: "Fo Free", price: 400) }

  before(:each) do
    User.create(email: "david@example.com", password: "password")
    mike = User.create(email: "mike@example.com", password: "password")
    mike.orders.create
  end

  xscenario "when they visit /orders" do
    visit login_path
    fill_in("Email", with: "david@example.com")
    fill_in("Password", with: "password")
    click_on("Login")
    click_on("Meals")
    click_on("Add Steak")
    click_on("Cart")
    click_on("Check Out")

    expect(page).to have_content("Steak 1 400")
    expect(user.orders.count).to eq(1)

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
