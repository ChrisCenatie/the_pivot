require 'rails_helper'

describe 'can view an item show page', type: :feature do
  let(:item) { Item.last }

  before(:each) do
   Item.create(name: "Soda", description: "Teh bubbles", price: 1, category_id: 1) 
   User.create(email: "david@example.com", password: "password")
  end


  scenario 'from the item index' do
    visit items_path
    click_on "Soda" 

    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('$1.00')
  end

  scenario 'from the cart' do
    visit items_path
    click_on "Add Soda" 
    click_on "Cart" 
    click_on "Soda"

    expect(current_path).to eq(item_path(item))

    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('$1.00')
  end

  scenario 'from past orders' do
    visit items_path
    click_on "Add Soda" 
    click_on "Cart"
    click_on "Check Out" 

    fill_in "Email", with: "david@example.com"
    fill_in "Password", with: "password"

    click_button("Login")
    click_button("Check Out")
    click_on "Soda" 

    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('$1.00')
  end
end
