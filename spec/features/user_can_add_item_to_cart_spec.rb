require "rails_helper"

RSpec.feature "user can add item to cart" do
  before(:each) do
    @category = Category.create(name: "Meals")
    @farmer1  = Farmer.create(name: "McDonald")
    @farmer2  = Farmer.create(name: "Jebediah")
    @item1    = Item.create(name: "Fries", description: "Salty", price: 4, category_id: @category.id, farmer_id: @farmer1.id)
    @item2    = Item.create(name: "Burger", description: "Beef", price: 1, category_id: @category.id, farmer_id: @farmer2.id)
  end

  scenario "on item index page" do
    visit category_items_path(@category)

    click_on("Add Fries")
    expect(page).to have_content("Successfully added Fries")
    click_on("Add Burger")
    expect(page).to have_content("Successfully added Burger")
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")
    expect(page).to have_content("Burger")
    expect(page).to have_content("1")
    expect(current_path).to eq(cart_path)
  end

  scenario "from multiple farmers item index pages" do
    visit farmer_items_path(@farmer1.slug)
    click_on("Add Fries")
    expect(page).to have_content("Successfully added Fries")

    visit farmer_items_path(@farmer2.slug)
    click_on("Add Burger")
    expect(page).to have_content("Successfully added Burger")
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")
    expect(page).to have_content("Burger")
    expect(page).to have_content("1")
    expect(current_path).to eq(cart_path)
  end

  scenario "on cart page" do
    visit category_items_path(@category)

    click_on("Add Fries")
    expect(page).to have_content("Successfully added Fries")
    click_on("Add Burger")
    click_on("Cart")
    within(:css, "div#item_#{@item1.id}") do
      click_on("+")
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Fries")
    expect(page).to have_content("2")
    expect(page).to have_content("$8.00")
    expect(page).to have_content("$9.00")
  end
end
