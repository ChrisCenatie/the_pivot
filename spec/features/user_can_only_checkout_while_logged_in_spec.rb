require "rails_helper"

RSpec.feature "user can only checkout while logged in" do
  it "directs user to login page from cart checkout" do
    visit items_path

    click_on("Add Fries")

    visit cart_path

    click_on("Check Out")

    expect(current_path).to eq(signup_path)
    expect(page).to have_content("Create Your Account")
  end
end
