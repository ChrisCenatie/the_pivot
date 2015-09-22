require "rails_helper"

RSpec.feature "user can view categories" do

  it "can view categories as a guest" do
    visit "/items"
    click_link("View by category")
    expect(current_path).to eq(categories_path)
    expect(page).to have_content("Meals")
    expect(page).to have_content("Drinks")
    expect(page).to have_content("Sides")

    click_link("Meals")

    category = Category.find_by(name: "Meals")

    expect(current_path).to eq(category_path(category.id))
    expect(page).to have_content("Burger")
    expect(page).to have_content("Steak")
    expect(page).to have_content("For a rabbi")
    expect(page).to have_content("200")
  end

end
