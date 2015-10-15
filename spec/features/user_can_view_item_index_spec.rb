require 'rails_helper'

describe 'the item view', type: :feature do

  it 'shows the items' do
    create_category!
    create_item!

    visit category_items_path(@category)

    expect(page).to have_content('Fries')
    expect(page).to have_content('Yummy')
    expect(page).to have_content("$4.00")
  end
end
