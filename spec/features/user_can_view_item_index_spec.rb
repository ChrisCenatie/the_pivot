require 'rails_helper'

describe 'the item view', type: :feature do

  it 'shows the items' do
    @category = Category.create(name: "Meals")
    Item.create(name: 'Fries', description: 'Fo Free', price: 4, category_id: @category.id)
    visit category_items_path(@category)

    expect(page).to have_content('Fries')
    expect(page).to have_content('Fo Free')
    expect(page).to have_content("$4.00")
  end
end
