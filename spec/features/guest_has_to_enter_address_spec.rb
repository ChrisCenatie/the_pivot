require "rails_helper"

RSpec.feature "guest has to enter address" do
  let(:order) { Order.last }
  let(:user)  { User.last }

  before(:each) do
    category = Category.create(name: "Meals")
    Item.create(category_id: category.id, name: "Burger",
        description: "For a rabbi", price: 200)
    Item.create(category_id: category.id, name: "Steak",
        description: "Fo Free", price: 400)
  end

  scenario "after clicking check out in cart page" do
    visit root_path
    click_on("Add Burger")
    click_on("Cart")
    click_on("Check Out")
    click_on("Sign up")
    fill_in("Email", with: "josh@example.com")
    fill_in("Password", with: "password")
    click_on("Create Account")
    click_on("Cart")
    click_on("Check Out")

    expect(current_path).to eq(edit_user_path(user))

    fill_in("First Name", with: "Josha")
    fill_in("Last Name", with: "Mejia")
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
    click_on("Check Out")

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("Status: Ordered")
  end
end
