require "rails_helper"

RSpec.feature "user can only checkout while logged in" do
  it "directs user to login page from cart checkout" do
    Item.create(name: "Fries", description: "Salty", price: 4, category_id: 1)

    visit items_path
    click_on("Add Fries")

    visit cart_path
    click_on("Check Out")

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Login")
  end

  it "clears cart on logout" do
    Item.create(name: "Fries", description: "Salty", price: 4, category_id: 1)

    visit items_path
    click_on("Add Fries")

    visit cart_path
    click_on("Check Out")

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Login")
  end
end
