require "rails_helper"

RSpec.feature "user logs out" do

  scenario "when previously logged in" do
    visit root_path
    click_link("Sign up")

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button("Create Account")

    expect(page).to have_content("Justin@example.com")
    click_link("Logout")
    expect(current_path).to eq(root_path)
    expect(page).to have_content("You are now logged out")
    expect(page).to_not have_content("Logout")
  end

  scenario "when not logged in" do
    visit root_path

    expect(page).to_not have_content("Logout")
  end
end
