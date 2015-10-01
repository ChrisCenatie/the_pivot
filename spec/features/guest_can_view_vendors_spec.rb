require "rails_helper"

RSpec.feature "all users" do

  scenario "can see the splash page" do
    visit root_path
    click_on("I'm Hungry")

    expect(current_path).to eq(vendors_path)

    expect(page).to have_link("Fontana")
    expect(page).to have_link("Sushi Supply")
    expect(page).to have_link("El")
  end
end
