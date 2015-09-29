require "rails_helper"

RSpec.feature "user can only checkout while logged in" do
  before(:each) do
    @category = Category.create(name: "Meals")
  end

  it "directs user to login page from cart checkout" do
    Item.create(name: "Fries", description: "Salty", price: 4, category_id: @category.id)

    visit category_items_path(@category)
    click_on("Add Fries")

    visit cart_path
    click_on("Check Out")

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Login")
  end

  it "clears cart on logout" do
    Item.create(name: "Fries", description: "Salty", price: 4, category_id: @category.id)

    visit category_items_path(@category)
    click_on("Add Fries")

    visit cart_path
    click_on("Check Out")

    expect(current_path).to eq(login_path)
    expect(page).to have_content("Login")
  end
end
