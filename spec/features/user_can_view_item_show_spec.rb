require 'rails_helper'

describe 'can view an item show page', type: :feature do

  before(:each) do
    create_item!
    create_item1!
    create_user!
  end

  scenario 'from the item index' do
    visit category_items_path(category)
    click_on "Fries"

    expect(page).to have_content('Fries')
    expect(page).to have_content('Yummy')
    expect(page).to have_content('$4.00')
  end

  scenario 'from the cart' do
    visit category_items_path(category)
    click_on "Add Soda"
    click_on "Cart"
    click_on "Soda"

    expect(current_path).to eq(category_item_path(category, item1))

    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('$1.00')
  end

  scenario 'from past orders' do
    visit category_items_path(@category)
    click_on "Add Soda"
    click_on "Cart"
    click_on "Check Out"

    fill_in "Email", with: "justin@example.com"
    fill_in "Password", with: "password"

    click_button("Login")
    click_button("Check Out")
    input_user_info!
    click_button("Check Out")
    click_on "Soda"

    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
  end
end
