require "rails_helper"

RSpec.feature "user can view completed order" do
  before(:each) do
    User.create(email: "justin@example.com", password: "password")
    Item.create(name: 'Fries', description: 'Fo Free', price: 400)
  end

  scenario "after clicking checkout and then logging in" do
    visit items_path

    click_on("Add Fries")
    click_on("Cart")
    click_on("Add Fries")
    click_on("Check Out")

    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(current_path).to eq(cart_path)

    click_on("Check Out")

    order = Order.last
    expect(current_path).to eq(order_path(order))
  end
end
