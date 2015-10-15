require "rails_helper"

RSpec.feature "user can enter address in dashboard" do

  def enter_name
    fill_in("user_and_address[first_name]", with: "Josha")
    fill_in("user_and_address[last_name]", with: "Mejia")
    click_on("Update Name")
  end

  def enter_address
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update Address")
  end

  scenario "when logged in" do
    login_user!

    click_on("Hello, #{user.name}")
    click_on("Edit Profile")
    enter_name
    click_on("Edit Profile")
    enter_address

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("1510 Blake Street")
  end
end
