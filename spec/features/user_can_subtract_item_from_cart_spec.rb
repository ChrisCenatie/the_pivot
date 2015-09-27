require "rails_helper"

RSpec.feature "user can subtract item from cart" do
  before(:each) do
    Item.create(name: "Fries", description: "Salty", price: 4)
    visit items_path
    click_on("Add Fries")
  end

  it "can take an item out of the cart" do
    visit root_path
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")

    click_on("Remove Fries")

    expect(page).to_not have_content("Fries")
  end
end
