require 'rails_helper'
RSpec.feature 'admin adds item' do

  before(:each) do
    @category = Category.create(name: "Meals")
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

  def user_signs_up
    visit new_user_path
    fill_in("Email", with: "ryan@example.com")
    fill_in("Password", with: "password")
    click_on("Create Account")
  end

  it 'with valid params' do
    admin_logs_in
    visit category_items_path(@category)
    click_on("Add Item")

    expect(current_path).to eq(new_admin_item_path)

    expect(page).to have_content('New Item')

    fill_in("Name", with: "Roast Chicken")
    fill_in("Description", with: "Just like grandma's")
    fill_in("Price", with: "11.50")
    fill_in("Image Url", with: "http://www.reservoirhillsfamilybutchery.co.za/wp-content/uploads/2015/03/RoastChicken.jpg")
    click_on("Create Item")

    expect(current_path).to eq(category_items_path(@category))
    expect(page).to have_content('Roast Chicken')
    expect(page).to have_content("$11.50")
  end

  it 'user cannot see add item link' do
    user_signs_up
    visit category_items_path(@category)

    expect(page).to_not have_content('Add Item')
  end
end
