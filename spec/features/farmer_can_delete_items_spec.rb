require "rails_helper"

RSpec.feature "farmer admin can" do

  before(:each) do
    create_item!
    login_farmer_admin!
  end

  scenario "delete items with valid params" do
    visit category_items_path(category)

    expect(page).to have_content("Delete")
    click_on("Delete")

    expect(current_path).to eq(category_items_path(category))

    expect(page).to_not have_content("Fries")
    expect(page).to_not have_content("Yummy")
  end

  scenario "not delete item from another farmer" do
    create_item1!

    visit category_items_path(category)

    within("#item#{item1.id}") do
      expect(page).to_not have_content("Delete")
    end
  end
end
