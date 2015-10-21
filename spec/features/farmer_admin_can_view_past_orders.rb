require "rails_helper"

RSpec.feature "farmer admin can" do

  before(:each) do
    create_item!
    create_order!
    click_on("Logout")
    login_farmer_admin!
  end

  scenario "view order data related to only items sold by farmer`" do
    visit farmer_admin_dashboard_path

    expect(page).to have_content("Orders")
    expect(page).to have_content("Fries")
    expect(page).to_not have_content("Soda")
    expect(page).to have_content("$8.00")
    expect(page).to_not have_content("$1.00")
    expect(page).to have_content("paid")
  end
end
