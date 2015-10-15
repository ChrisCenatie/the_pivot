require "rails_helper"

RSpec.feature "all users" do

  scenario "can see the splash page" do
    farmer
    farmer2
    
    visit root_path
    click_on("Search by Farmer")

    expect(current_path).to eq(farmers_path)

    expect(page).to have_link("George")
    expect(page).to have_link("McDonald")
  end
end
