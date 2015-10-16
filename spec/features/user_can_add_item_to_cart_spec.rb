require "rails_helper"

RSpec.feature "user can add item to cart" do
  before(:each) do
    create_item!
    create_item1!
  end

  scenario "on item index page" do
    visit category_items_path(category)

    click_on("Add Fries")
    expect(page).to have_content("Successfully added Fries")
    click_on("Add Soda")
    expect(page).to have_content("Successfully added Soda")
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")
    expect(page).to have_content("Offered by George")
    expect(page).to have_content("Soda")
    expect(page).to have_content("1")
    expect(current_path).to eq(cart_path)
  end

  scenario "from multiple farmers item index pages" do
    visit farmer_items_path(farmer.slug)
    click_on("Add Fries")
    expect(page).to have_content("Successfully added Fries")

    visit farmer_items_path(farmer2.slug)
    click_on("Add Soda")
    expect(page).to have_content("Successfully added Soda")
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")
    expect(page).to have_content("Soda")
    expect(page).to have_content("1")
    expect(current_path).to eq(cart_path)
  end

  scenario "from multiple farmer index pages" do
    visit farmers_path
    click_on("McDonald")
    expect(current_path).to eq("/mcdonald/items")
    click_on("Add Soda")
    expect(page).to have_content("Successfully added Soda")

    visit farmers_path
    click_on("George")
    expect(current_path).to eq("/george/items")
    click_on("Add Fries")
    expect(page).to have_content("Successfully added Fries")
    click_on("Cart")

    expect(page).to have_content("Fries")
    expect(page).to have_content("1")
    expect(page).to have_content("Soda")
    expect(page).to have_content("1")
    expect(current_path).to eq(cart_path)
  end

  scenario "on cart page" do
    visit category_items_path(category)

    click_on("Add Fries")
    expect(page).to have_content("Successfully added Fries")
    click_on("Add Soda")
    click_on("Cart")
    within(:css, "div#item_#{item1.id}") do
      click_on("+")
    end

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Soda")
    expect(page).to have_content("2")
    expect(page).to have_content("$4.00")
    expect(page).to have_content("$2.00")
  end
end
