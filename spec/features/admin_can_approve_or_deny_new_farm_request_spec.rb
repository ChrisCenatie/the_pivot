require "rails_helper"

RSpec.feature "platform admin can" do

  before(:each) do
    create_farmers!
    create_new_farmers!
    login_admin!
  end

  scenario "approve/deny new farm requests" do
    click_on "Manage Farms"

    expect(current_path).to eq(admin_farmers_path)
    expect(page).to have_content("George")
    expect(page).to have_content("McDonald")
    expect(page).to have_content("Reginald")
    expect(page).to have_content("Jebediah")
    expect(page).to have_link("Deactivate")

    within("#Reginald") do
      expect(page).to have_link("Activate")
    end

    within("#Reginald") do
      click_on "Activate"
    end

    within("#Reginald") do
      expect(page).to have_link("Deactivate")
    end

    within("#Jebediah") do
      expect(page).to have_link("Activate")
    end

    within("#Jebediah") do
      click_on "Activate"
    end

    within("#Jebediah") do
      expect(page).to have_link("Deactivate")
    end
  end
end
