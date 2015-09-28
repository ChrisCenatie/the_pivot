require 'rails_helper'
RSpec.feature 'admin adds item' do

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

  it 'with valid params' do
    Category.create(name: "Meals")
    Category.create(name: "Drinks")
    admin_logs_in
    visit items_path
    click_on("Add Item")

    expect(current_path).to eq(new_item_path)

    expect(page).to have_content('New Item')
    expect(page).to have_content('Category')

    fill_in("Name", with: "Roast Chicken")
    fill_in("Description", with: "Just like grandma's")
    fill_in("Price", with: "11.50")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    select("Meals", from: "item[category_id]")

    click_on("Create Item")
    expect(current_path).to eq(items_path)

    expect(page).to have_content('Roast Chicken')
    expect(page).to have_content("$11.50")
  end

end
