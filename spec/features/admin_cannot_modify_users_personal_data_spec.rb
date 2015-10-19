require "rails_helper"

RSpec.feature "admin cannot modify users personal data" do
  before(:each) do
    User.create(email: "admin@example.com",
                password: "password",
                role: 3)

  end

  def enter_name
    fill_in("user_and_address[first_name]", with: "Ryan")
    fill_in("user_and_address[last_name]", with: "da-Man")
    click_on("Update Name")
  end

  def enter_address
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
  end

  scenario "from their profile" do
    login_user!
    click_on("Edit Profile")
    enter_name
    click_on("Add Address")
    enter_address
    click_on("Logout")
    login_admin!
    visit edit_user_path(user)

    expect(page.status_code).to eq(401)
  end
end
