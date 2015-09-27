require "rails_helper"

RSpec.feature "guest has to enter address" do
  let(:order) { Order.last }

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
    click_on("Check out")

    expect(current_path).to eq(new_address_path)

    fill_in("First name", with: "Josh")
    fill_in("Last name", with: "Mejia")
    fill_in("Address", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Complete order")

    expect(page).to have_content("Status: Ordered")
    expect(current_path).to eq(order_path(order))
  end
end
