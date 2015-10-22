require "rails_helper"

RSpec.feature "farmer admin can" do

  before(:each) do
    create_order!
    click_on("Logout")
    login_farmer_admin!
    visit farmer_admin_dashboard_path
  end

  scenario "cancel there portion of the order" do

    within(".paid") do
      expect(page).to have_content("Fries")
      expect(page).to have_content("$8.00")
      expect(page).to have_content("paid")
      expect(page).to_not have_content("cancelled")
      click_on("Cancel Order")
    end

    expect(current_path).to eq(farmer_admin_dashboard_path)

    expect(page).to have_content("Order has been cancelled!")
    expect(page).to_not have_content("Fries")
    expect(page).to_not have_content("$8.00")
    expect(page).to_not have_content("paid")
    expect(page).to_not have_content("Cancel Order")
  end

  scenario "cancel only orders where order status is not already cancelled" do
    Order.first.update(status: "cancelled")
    visit farmer_admin_dashboard_path

    expect(page).to_not have_content("Cancel Order")
    expect(page).to have_content(" - ")
  end

  scenario "can not cancel another farmer admin's orders" do
    within(".paid") do
      click_on("Cancel Order")
    end
    click_on("Logout")
    User.create(email: "mcdonald@example.com",
                password: "password",
                role: 2,
                farmer_id: farmer2.id,
                first_name: "Another",
                last_name: "McDonald",
                phone_number: "null")
    visit login_path
    fill_in("Email", with: "mcdonald@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(current_path).to eq(farmer_admin_dashboard_path)
    expect(page).to have_content("McDonald Dashboard")
    within(".paid") do
      expect(page).to have_content("Soda")
      expect(page).to have_content("$1.00")
      expect(page).to have_content("paid")
      expect(page).to have_content("Cancel Order")
    end
  end
end
