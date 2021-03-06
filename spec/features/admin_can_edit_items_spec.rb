require "rails_helper"

RSpec.feature "admin can" do

  before(:each) do
    create_item!
    login_admin!
  end

  scenario "edit items with valid params" do
    visit category_items_path(category)

    expect(page).to have_content("Edit")

    click_on("Edit")

    expect(current_path).to eq(edit_admin_item_path(Item.last))

    fill_in("Name", with: "Roast Beef")
    fill_in("Description", with: "Just like Pa's")
    fill_in("Price", with: "15.00")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    click_on("Update Item")

    expect(current_path).to eq(category_items_path(category))
    expect(page).to have_content("Roast Beef")
    expect(page).to have_content("Pa's")
    expect(page).to have_content("$15.00")
  end

  scenario "edit item with invalid params" do
    visit category_items_path(category)
    click_on("Edit")
    fill_in("Name", with: "Roast Beef")
    fill_in("Description", with: "Just like Pa's")
    fill_in("Price", with: "hello")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    click_on("Update Item")

    expect(current_path).to eq(edit_admin_item_path(Item.last))
    expect(page).to have_content("Invalid update params")
  end
end
