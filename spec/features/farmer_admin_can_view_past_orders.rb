require "rails_helper"

RSpec.feature "farmer admin can" do

  before(:each) do
    create_item!
    create_order!
    click_on("Logout")
    login_farmer_admin!
  end

  scenario "view orders" do
    visit farmer_admin_dashboard_path

    expect(page).to have_content("Orders")
    # click_on("Edit")
    #
    # expect(current_path).to eq(edit_farmer_admin_item_path(Item.last))
    #
    # fill_in("item[name]", with: "Roast Beef")
    # fill_in("item[description]", with: "Just like Pa's")
    # fill_in("item[price]", with: "15.00")
    # fill_in("item[image_url]", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    # click_on("Update Item")
    #
    # expect(current_path).to eq(category_items_path(category))
    # expect(page).to have_content("Roast Beef")
    # expect(page).to have_content("Pa's")
    # expect(page).to have_content("$15.00")
  end
end
