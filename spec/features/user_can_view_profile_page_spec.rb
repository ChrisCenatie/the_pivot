require "rails_helper"

RSpec.feature "user can view profile page" do

  before(:each) do
    login_user!
    create_category!
    create_user!
    create_item!
    create_item2!
    @user = User.first
  end

  scenario "and see past orders" do
    create_order!
    order = Order.last
    click_on("Past orders")

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Order #{order.id}")
  end

  scenario "and change their email" do
    click_on("Edit Profile")
    fill_in("#{@user.email}", with: "ryan@example.com")
    click_on("Update Email")

    expect(User.first.email).to eq("ryan@example.com")
  end

  scenario "and add their address" do
    click_on("Edit Profile")
    click_on("Add Address")
    fill_in("Street", with: "1501 Blake St")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80202")
    click_on("Update")

    expect(page).to have_content("Address successfully added")
    expect(current_path).to eq(edit_user_path(user.id))
    expect(User.first.full_address).to eq("1501 Blake St  Denver, CO 80202")
  end

  scenario "and update their address" do
    Address.create(user_id: @user.id,
      street_address: "111 Blake Street",
      city: "Denver", zip_code: 80203, state: "CO")
    click_on("Edit Profile")
    fill_in("111 Blake Street", with: "1501 Blake St")
    fill_in("Denver", with: "Denver")
    fill_in("CO", with: "CO")
    fill_in("80203", with: "80202")
    click_on("Update Address")

    expect(page).to have_content("Address successfully updated")
    expect(current_path).to eq(edit_user_path(user.id))
    expect(User.first.full_address).to eq("1501 Blake St  Denver, CO 80202")
  end

  scenario "and change their name" do
    click_on("Edit Profile")
    fill_in("user_and_address[first_name]", with: "Ryan")
    fill_in("user_and_address[last_name]", with: "Example")
    click_on("Update Name")

    expect(User.first.full_name).to eq("Ryan Example")
  end

  scenario "and change their password" do
    click_on("Edit Profile")

    fill_in("Enter New Password", with: "asdf")
    click_on("Update Password")
    click_on("Logout")
    click_on("Login")
    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "asdf")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(page).to have_content("Hello, Justin")
  end
end
