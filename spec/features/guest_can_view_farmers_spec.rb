require "rails_helper"

RSpec.feature "all users" do

  def create_farmers
    farmer
    farmer2
  end

  scenario "can see the splash page" do
    create_farmers

    visit root_path
    click_on("Search by Farmer")

    expect(current_path).to eq(farmers_path)

    expect(page).to have_link("George")
    expect(page).to have_link("McDonald")
  end
end
