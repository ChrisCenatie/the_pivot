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
    click_on("Update")
  end

  scenario "when logged in" do
    login_user!

    click_on("Hello, #{user.name}")
    click_on("Edit Profile")

    expect(page).to have_link("Back to Profile")

    click_on("Back to Profile")

    expect(current_path).to eq(user_path(user))

    click_on("Edit Profile")
    enter_name

    expect(page).to have_content("Hello, Josh")
    expect(current_path).to eq(edit_user_path(user.id))

    click_on("Add Address")

    expect(current_path).to eq(new_address_path)

    enter_address

    expect(current_path).to eq(edit_user_path(user.id))
    expect(page).to have_content("Address successfully added")

    fill_in("address[street_address]", with: "1515 Blake Street")
    fill_in("address[city]", with: "Denver")
    fill_in("address[state]", with: "CO")
    fill_in("address[zip_code]", with: "80012")
    click_on("Update Address")

    expect(current_path).to eq(edit_user_path(user.id))
    expect(page).to have_content("Address successfully updated")
  end

  scenario "with missing parameters" do
    login_user!

    click_on("Hello, #{user.name}")
    click_on("Edit Profile")
    fill_in("user_and_address[first_name]", with: "Josh")
    click_on("Update Name")

    expect(current_path).to eq(edit_user_path(user.id))
    expect(page).to have_content("Invalid input params")
    expect(page).to_not have_content("Hello, Josh")

    click_on("Add Address")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")

    expect(current_path).to eq(new_address_path)
    expect(page).to have_content("Street address can't be blank")

    enter_address

    expect(current_path).to eq(edit_user_path(user.id))
    fill_in("address[state]", with: "Colorado")
    click_on("Update Address")

    expect(current_path).to eq(edit_user_path(user.id))
    expect(page).to have_content("Invalid Address Attributes")
  end
end
