require "rails_helper"

RSpec.feature "admin cannot modify users personal data" do
  before(:each) do
    User.create(email: "admin@example.com", password: "password", role: 3)
    @user = User.create(email: "ryan@example.com", password: "password")
  end

  def log_in_user
    visit root_path
    click_on("Login")
    fill_in "Email", with: "ryan@example.com"
    fill_in "Password", with: "password"
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  def enter_name_and_address
    fill_in("First Name", with: "Ryan")
    fill_in("Last Name", with: "da-Man")
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
  end

  def admin_logs_in
    visit login_path
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  scenario "from their profile" do
    log_in_user
    click_on("Edit Profile")
    enter_name_and_address
    click_on("Logout")
    admin_logs_in
    visit edit_user_path(@user)

    expect(page.status_code).to eq(401)
  end
end
