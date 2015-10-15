require "rails_helper"

RSpec.feature "admin can" do

  scenario "edit items with valid params" do
    create_item!
    login_admin!
    visit category_items_path(category)

    expect(page).to have_content("Delete")
    click_on("Delete")

    expect(current_path).to eq(category_items_path(category))

    expect(page).to_not have_content("Fries")
    expect(page).to_not have_content("Yummy")
  end
end
