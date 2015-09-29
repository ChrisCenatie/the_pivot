require "rails_helper"

RSpec.feature "user can view categories" do

  before(:each) do
    User.create(email: "justin@example.com", password: "password")
    Category.create(name: "Drinks")
    Category.create(name: "Sides")
  end

  it "can view categories as a guest" do
    category = Category.create(name: "Meals")
    Item.create(category_id: category.id, name: "Burger", description: "For a rabbi", price: 2)
    Item.create(category_id: category.id, name: "Steak", description: "Fo Free", price: 4)

    visit category_items_path(category)

    click_link("View by category")

    expect(current_path).to eq(categories_path)
    expect(page).to have_content("Meals")
    expect(page).to have_content("Drinks")
    expect(page).to have_content("Sides")

    click_link("Meals")

    expect(current_path).to eq(category_path(category.id))
    expect(page).to have_content("Burger")
    expect(page).to have_content("Steak")
    expect(page).to have_content("For a rabbi")
    expect(page).to have_content("$2.00")
  end

end
