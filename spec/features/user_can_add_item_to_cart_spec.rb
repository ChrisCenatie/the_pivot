require "rails_helper"

RSpec.feature "user can add item to cart" do
  it "has the item in the cart" do
    visit items_path

    click_on("Add Fries")

    visit cart_path

    expect(page).to have_content("Fries 1")
    expect(current_path).to eq(cart_path)
  end
end
