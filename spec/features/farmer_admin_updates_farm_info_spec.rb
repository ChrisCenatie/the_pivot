require "rails_helper"

RSpec.feature "farmer admin updates farm info" do

  before(:each) do
    login_farmer_admin!
  end

  scenario "with valid params as an authenticated farmer admin" do

    expect(page).to have_link("Edit George Info")
    click_on("Edit George Info")

    fill_in("farmer[name]", with: "Updated Farm")
    fill_in("farmer[image_url]", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    click_on("Update Item")

    expect(current_path).to eq(farmer_admin_dashboard_path)
    expect(page).to_not have_content("George")
    expect(page).to have_content("Updated Farm")
  end

  scenario "with invalid params as an authenticated farmer admin" do

    expect(page).to have_link("Edit George Info")
    click_on("Edit George Info")

    fill_in("farmer[name]", with: "Ab")
    fill_in("farmer[image_url]", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    click_on("Update Item")

    expect(current_path).to eq(edit_farmer_admin_farmer_path(farmer))
    expect(page).to have_content("too short")
  end

end
