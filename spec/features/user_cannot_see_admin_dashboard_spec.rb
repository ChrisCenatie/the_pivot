require "rails_helper"

RSpec.feature "user cannot see admin dashboard" do
  before(:each) do
    User.create(email: "Justin@example.com", password: "password")
  end

  scenario "when not an admin" do
    visit root_path
    click_link("Login")
    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button("Login")
    visit admin_dashboard_path

    expect(page.status_code).to eq(404)
  end

  scenario "when not logged in" do
    visit admin_dashboard_path

    expect(page.status_code).to eq(404)
  end

end
