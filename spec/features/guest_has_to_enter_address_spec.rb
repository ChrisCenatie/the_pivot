require "rails_helper"

RSpec.feature "guest has to enter address" do
  let(:order) { Order.last }
  let(:user)  { User.last }

  before(:each) do
    create_item!
    create_item1!
  end

  scenario "after clicking check out in cart page" do
    visit category_items_path(category)
    click_on("Add Soda")
    click_on("Cart")
    click_on("Check Out")
    click_on("Sign up")
    fill_in("Email", with: "josh@example.com")
    fill_in("Password", with: "password")
    fill_in("First name", with: "Josh")
    fill_in("Last name", with: "Joshington")
    fill_in("Phone number", with: "9292266613")
    click_on("Create Account")
    click_on("Cart")
    click_on("Check Out")

    expect(current_path).to eq(new_address_path)

    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")

    expect(page).to have_content("Address successfully added")

    click_on("Check Out")

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("Status: Paid")
  end

  scenario "with valid address attributes" do
    visit category_items_path(category)
    click_on("Add Soda")
    click_on("Cart")
    click_on("Check Out")
    click_on("Sign up")
    fill_in("Email", with: "josh@example.com")
    fill_in("Password", with: "password")
    fill_in("First name", with: "Josh")
    fill_in("Last name", with: "Joshington")
    fill_in("Phone number", with: "9292266613")
    click_on("Create Account")
    click_on("Cart")
    click_on("Check Out")

    expect(current_path).to eq(new_address_path)

    fill_in("Street", with: "1510 Blake Street")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")

    expect(current_path).to eq("/addresses")
    expect(page).to have_content("City can't be blank")

    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")

    expect(page).to have_content("Address successfully added")
    expect(current_path).to eq("/addresses/new")
    click_on("Cart")
    click_on("Check Out")

    expect(current_path).to eq(order_path(order))
    expect(page).to have_content("Status: Paid")
  end

end
