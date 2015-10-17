require "rails_helper"

RSpec.feature "user cannot checkout" do

  scenario "with empty cart" do
    visit cart_path
    click_on "Check Out"

    expect(current_path).to eq(cart_path)
    expect(page).to have_content("Cart is empty! Fill it up with some fast flying farm fresh food!")
  end

end
