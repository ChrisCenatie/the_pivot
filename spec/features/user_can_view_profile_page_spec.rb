require "rails_helper"

RSpec.feature "user can view profile page" do 
  def create_order
    visit items_path

    click_on("Add Fries")
    click_on("Add Burger")
    click_on("Cart")
    click_on("Add Fries")
    click_on("Check Out")

    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
    click_on("Check Out")
  end

  before(:each) do
    User.create(email: "justin@example.com", password: "password")
    item1 = Item.create(name: 'Fries', description: 'Fo Free', price: 4, category_id: 1)
    item2 = Item.create(name: 'Burger', description: 'for a rabbi', price: 3.5, category_id: 1)
  end

  scenario "and see past orders" do
    create_order
    user = User.first
    order = Order.last

    click_on("Hello, justin")

    expect(current_path).to eq(user_path(user.id))
    expect(page).to have_content("Order History")

    click_on("Order History")

    expect(current_path).to eq(orders_path)
  end
end
