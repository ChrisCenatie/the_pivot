require "rails_helper"

RSpec.feature "farmer admin logs in" do

  scenario "with valid credentials and is redirected to farmer dashboard" do
    create_farmer_admin!
    visit login_path
    fill_in("Email", with: "farmer@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(current_path).to eq(farmer_admin_dashboard_path)
    expect(page).to have_content("George Dashboard")
  end

end
