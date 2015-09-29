require "rails_helper"

RSpec.feature "user can view profile page" do
  def create_order
    visit category_items_path(@category)

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
    @category = Category.create(name: "Meals")
    Item.create(name: 'Fries', description: 'Fo Free', price: 4, category_id: @category.id)
    Item.create(name: 'Burger', description: 'for a rabbi', price: 3.5, category_id: @category.id)
  end

  scenario "and see past orders" do
    create_order
    user = User.first
    Order.last
    click_on("Hello, justin")
    expect(current_path).to eq(user_path(user.id))
    click_on("Past Orders")

    expect(current_path).to eq(orders_path)
  end
end
