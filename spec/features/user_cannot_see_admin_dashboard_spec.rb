require "rails_helper"

RSpec.feature "user cannot see admin dashboard" do
  before(:each) do
    create_user!
  end

  scenario "when not an admin" do
    visit root_path
    click_link("Login")
    fill_in "Email", with: "justin@example.com"
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
