require "rails_helper"

RSpec.feature "user can enter address in dashboard" do
  let(:user) { User.last }
  before(:each) do
    User.create(email: "david@example.com", password: "password")
  end

  def enter_name_and_address
    fill_in("First Name", with: "Josha")
    fill_in("Last Name", with: "Mejia")
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
  end

  scenario "when logged in" do
    visit root_path
    click_on("Login")
    fill_in "Email", with: "david@example.com"
    fill_in "Password", with: "password"
    within(:css, "div#login_form") do
      click_on("Login")
    end

    click_on("Hello, #{user.name}")
    click_on("Change Address")
    enter_name_and_address

    expect(current_path).to eq(user_path(user))
    expect(page).to have_content("1510 Blake Street")
  end
end
