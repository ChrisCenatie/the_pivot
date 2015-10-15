require "rails_helper"

RSpec.feature "user can view categories" do

  it "can view categories as a guest" do
    Category.create(name: "Drinks")
    Category.create(name: "Sides")
    create_item!
    create_item1!

    visit category_items_path(category)

    click_link("View by category")

    expect(current_path).to eq(categories_path)
    expect(page).to have_content("Meals")
    expect(page).to have_content("Drinks")
    expect(page).to have_content("Sides")

    click_link("Meals")

    expect(current_path).to eq(category_path(category.id))
    expect(page).to have_content("Fries")
    expect(page).to have_content("Soda")
    expect(page).to have_content("Yummy")
    expect(page).to have_content("$4.00")
  end

end
