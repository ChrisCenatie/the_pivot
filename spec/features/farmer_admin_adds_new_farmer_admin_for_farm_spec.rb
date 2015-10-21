require "rails_helper"

RSpec.feature "farmer admin adds new farmer admin" do

  before(:each) do
    login_farmer_admin!
  end

  scenario "from existing user" do
    create_user!

    within("#farm_management") do
      expect(page).to_not have_content("Justin Beiber")
    end
    expect(page).to have_link("Add Farmer Admin")
    click_on("Add Farmer Admin")

    expect(current_path).to eq(new_farmer_admin_user_path)
    within("#new_farm_admin_email") do
      fill_in("Email", with: "justin@example.com")
      click_on("Add Administrator")
    end
    expect(current_path).to eq(farmer_admin_dashboard_path)
    within("#farm_management") do
      expect(page).to have_content("Justin Beiber")
    end
  end

  scenario "creating new account" do
    within("#farm_management") do
      expect(page).to_not have_content("Ezekiel")
    end

    click_on("Add Farmer Admin")

    within("#login_form") do
      fill_in("Email", with: "NewFarmAdmin@example.com")
      fill_in("Password", with: "password")
      fill_in("First name", with: "Ezekiel")
      fill_in("Last name", with: "Sabbath")
      fill_in("Phone number", with: "3213214321")
      click_on("Create Account")
    end

    expect(current_path).to eq(farmer_admin_dashboard_path)
    within("#farm_management") do
      expect(page).to have_content("Ezekiel")
    end
  end

end
