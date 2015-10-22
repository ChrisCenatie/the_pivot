require "rails_helper"

RSpec.feature "user can add items from category items" do

  scenario "and return to category items page" do
    create_item!
    visit category_items_path(item.category)
    click_on("Fries")
    click_on("Cart")
    click_on("Fries")
    click_on("+")
    expect(current_path).to eq(cart_path)
  end


end
