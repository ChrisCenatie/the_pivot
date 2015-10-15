require "rails_helper"

RSpec.feature "user can only checkout while logged in" do

  it "directs user to login page from cart checkout" do
    create_item!

    visit category_items_path(category)
    click_on("Add Fries")

    visit cart_path
    click_on("Check Out")

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Login")
  end

end
