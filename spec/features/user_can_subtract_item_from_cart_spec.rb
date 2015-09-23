require "rails_helper"

RSpec.feature "user can subtract item from cart" do
  before(:each) do
    visit items_path
    click_on("Add Fries")
  end

  it "can take an item out of the cart" do
    visit root_path
    click_on("Cart")

    expect(page).to have_content("Fries 1")

    click_on("Remove Fries")

    expect(page).to_not have_content("Fries 1")
  end
end
