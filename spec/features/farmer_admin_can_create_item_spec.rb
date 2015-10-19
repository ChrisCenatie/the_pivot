require "rails_helper"

RSpec.feature "farmer admin can" do

  before(:each) do
    create_item!
    login_farmer_admin!
  end

  scenario "create items with valid params from item category path" do
    visit category_path(category)

    expect(page).to have_link("Add Item")
    click_on("Add Item")

    expect(current_path).to eq(new_farmer_admin_item_path)

    fill_in("Name", with: "New Item")
    fill_in("Description", with: "it's new!")
    fill_in("Price", with: "12.01")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    #selct category
    click_on("Create Item")

    expect(current_path).to eq(category_path(category))
    expect(page).to have_content("New Item")
    expect(page).to have_content("it's new!")
    expect(page).to have_content("$12.01")
  end

  scenario "get to new item path from their farmer path" do
    visit farmer_items_path(farmer)

    expect(page).to have_content("Add Item")
    click_on("Add Item")

    expect(current_path).to eq(new_farmer_admin_item_path)
  end

  scenario "edit item with invalid params" do
    visit category_path(category)
    click_on("Add Item")
    fill_in("Name", with: "Invalid Item")
    fill_in("Description", with: "my price isn't in the right format")
    fill_in("Price", with: "hello")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    click_on("Create Item")

    expect(current_path).to eq(new_farmer_admin_item_path)
    expect(page).to have_content("Price is not a number")
  end

  scenario "not create item from another farmer's page" do
    visit farmer_items_path(farmer1)

    expect(page).to_not have_content("Add Item")
  end
end
