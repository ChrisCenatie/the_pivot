require "rails_helper"

RSpec.feature "is redireceted from login" do
  before(:each) do
    create_user!
    create_item!
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
