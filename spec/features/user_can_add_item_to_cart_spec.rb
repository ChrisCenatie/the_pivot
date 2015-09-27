require "rails_helper"

RSpec.feature "user can add item to cart" do

  scenario "on item index page" do
    Item.create(name: "Fries", description: "Salty", price: 4)

    visit items_path

    click_on("Add Fries")
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")
    expect(current_path).to eq(cart_path)
  end

  scenario "on cart page" do
    Item.create(name: "Fries", description: "Salty", price: 4)

    visit items_path

    click_on("Add Fries")
    click_on("Cart")
    click_on("Add Fries")

    expect(page).to have_content("Fries")
    expect(page).to have_content("2")
    expect(current_path).to eq(cart_path)
  end
end
