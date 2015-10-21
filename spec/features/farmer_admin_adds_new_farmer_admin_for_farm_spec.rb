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

  scenario "with invalid email" do
    create_user!
    click_on("Add Farmer Admin")

    within("#new_farm_admin_email") do
      fill_in("Email", with: "xxsxtin@example.com")
      click_on("Add Administrator")
    end
    expect(current_path).to eq(new_farmer_admin_user_path)
    expect(page).to have_content("Couldn't find a user with that email")
  end

  scenario "by creating new account with valid parameters" do
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

  scenario "by creating new account with invalid parameters" do
    click_on("Add Farmer Admin")

    within("#login_form") do
      click_on("Create Account")
    end

    expect(current_path).to eq(new_farmer_admin_user_path)
    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Email is too short (minimum is 6 characters)")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Phone number can't be blank")
  end



end
