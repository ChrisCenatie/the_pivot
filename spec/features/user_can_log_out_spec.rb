require "rails_helper"

RSpec.feature "user logs out" do

  scenario "when previously logged in" do
    visit root_path
    click_link("Sign up")

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button("Create Account")

    expect(page).to have_content("Hello, Justin")
    click_link("Logout")
    expect(current_path).to eq(root_path)
    expect(page).to have_content("This is Faster Food")
    expect(page).to_not have_content("Logout")
  end

  scenario "when not logged in" do
    visit root_path

    expect(page).to_not have_content("Logout")
  end

  scenario "and cart is cleared" do
    @category = Category.create(name: "Meals")
    Item.create(name: 'Fries', description: 'Fo Free', price: 4, category_id: @category.id)
    Item.create(name: 'Burger', description: 'for a rabbi', price: 3.50, category_id: @category.id)

    visit root_path
    click_on("Sign up")

    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    click_on("Create Account")

    visit category_items_path(@category)

    click_on("Add Fries")
    click_on("Add Burger")
    click_on("Logout")

    click_on("Cart")
    expect(page).to_not have_content("Fries")
    expect(page).to_not have_content("Burger")
  end

end
