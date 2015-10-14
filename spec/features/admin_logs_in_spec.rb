require "rails_helper"

RSpec.feature "admin logs in" do

  def create_admin
    User.create(email: "admin@example.com",
                password: "password",
                role: 3)
  end

  scenario "with valid credentials and is redirected to dashboard" do
    create_admin
    visit login_path
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(page).to have_content("Dashboard")
    expect(current_path).to eq(admin_dashboard_path)
  end

end
