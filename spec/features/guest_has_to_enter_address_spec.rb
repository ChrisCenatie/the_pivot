require "rails_helper"

RSpec.feature "guest has to enter address" do
  let(:order) { Order.last }
  let(:user)  { User.last }

  before(:each) do
    create_item!
    create_item1!
  end

  scenario "after clicking check out in cart page" do
    skip "This test will be updated when an address controller is added"
    visit category_items_path(category)
    click_on("Add Soda")
    click_on("Cart")
    click_on("Check Out")
    click_on("Sign up")
    fill_in("Email", with: "josh@example.com")
    fill_in("Password", with: "password")
    fill_in("First name", with: "Josh")
    fill_in("Last name", with: "Joshington")
    fill_in("Phone number", with: "5555555555")
    click_on("Create Account")
    click_on("Cart")
    click_on("Check Out")

    expect(current_path).to eq(edit_user_path(user))

    fill_in("First Name", with: "Josha")
    fill_in("Last Name", with: "Mejia")
    fill_in("Phone Number", with: "9292266613")
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
    click_on("Check Out")

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("Status: Paid")
  end
end
