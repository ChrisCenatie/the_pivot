require "rails_helper"

RSpec.feature "user can subtract item from cart" do
  before(:each) do
    farmer = Farmer.create(name: "McDonald")
    @category = Category.create(name: "Meals")
    @item = Item.create(name: "Fries",
                        description: "Salty",
                        price: 4,
                        category_id: @category.id,
                        farmer_id: farmer.id)
    visit category_items_path(@category)
    click_on("Add Fries")
  end

  it "can take an item out of the cart" do
    visit root_path
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")

    within(:css, "div#item_#{@item.id}") do
      click_on("-")
    end

    expect(page).to have_content("Successfully removed Fries")
    expect(page).to_not have_content("1")
  end
end
