require "rails_helper"

RSpec.feature "platform admin can" do

  before(:each) do
    create_farmers!
    login_admin!
  end

  scenario "activate/deactivate farms" do
    click_on "Manage Farms"

    expect(current_path).to eq(admin_farmers_path)
    expect(page).to have_content("George")
    expect(page).to have_content("McDonald")
    expect(page).to have_link("Deactivate")

    within("#George") do
      click_on "Deactivate"
    end
    within("#George") do
      expect(page).to have_content("Activate")
    end
    within("#George") do
      click_on "Activate"
    end
    within("#George") do
      expect(page).to have_content("Deactivate")
    end
  end
end
