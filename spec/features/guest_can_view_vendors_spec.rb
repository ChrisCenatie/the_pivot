require "rails_helper"

RSpec.feature "all users" do

  scenario "can see the splash page" do
    visit root_path
    click_on("Search by Farmer")

    expect(current_path).to eq(vendors_path)

    expect(page).to have_link("Willowcroft")
    expect(page).to have_link("Zenger")
    expect(page).to have_link("Black River")
  end
end
