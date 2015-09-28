require "rails_helper"

RSpec.feature "admin can" do

  before(:each) do
    category = Category.create(name: "Meals")
    Item.create(category_id: category.id, name: "Roast Chicken", description: "Just like grandma's", price: "11.50")
  end

  def create_admin
    User.create(email: "admin@example.com", password: "password", role: 3)
  end

  def admin_logs_in
    create_admin
    visit login_path
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  scenario "edit items with valid params" do
    create_admin
    admin_logs_in
    visit items_path

    expect(page).to have_content("Edit")

    click_on("Edit")

    expect(current_path).to eq(edit_item_path(Item.last))

    fill_in("Name", with: "Roast Beef")
    fill_in("Description", with: "Just like Pa's")
    fill_in("Price", with: "15.00")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    select("Meals", from: "item[category_id]")
    click_on("Update Item")

    expect(current_path).to eq(items_path)
    expect(page).to have_content("Roast Beef")
    expect(page).to have_content("Pa's")
    expect(page).to have_content("$15.00")
  end

  scenario "edit item with invalid params" do
    create_admin
    admin_logs_in
    visit items_path
    click_on("Edit")
    fill_in("Name", with: "Roast Beef")
    fill_in("Description", with: "Just like Pa's")
    fill_in("Price", with: "hello")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    select("Meals", from: "item[category_id]")
    click_on("Update Item")

    expect(current_path).to eq(edit_item_path(Item.last))
    expect(page).to have_content("Invalid update params")
  end
end
