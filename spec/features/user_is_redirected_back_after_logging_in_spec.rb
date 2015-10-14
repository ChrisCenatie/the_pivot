require "rails_helper"

RSpec.feature "is redireceted from login" do
  before(:each) do
    User.create(email: "justin@example.com", password: "password")
    @category = Category.create(name: "Meals")
    farmer = Farmer.create(name: "McDonald")
    @item = Item.create(name: 'Fries',
                        description: 'Fo Free',
                        price: 4,
                        category_id: @category.id,
                        farmer_id: farmer.id)
  end

  scenario "after logging in from the cart" do
    visit category_items_path(@category)

    click_on("Add Fries")
    click_on("Cart")
    within(:css, "div#item_#{@item.id}") do
      click_on("+")
    end
    click_on("Check Out")

    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(current_path).to eq(cart_path)
  end
end
