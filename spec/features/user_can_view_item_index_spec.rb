require 'rails_helper'

describe 'the item view', type: :feature do

  it 'shows the items' do
    Item.create(name: 'Fries', description: 'Fo Free', price: 4)
    visit root_path
    visit items_path

    expect(page).to have_content('Fries')
    expect(page).to have_content('Fo Free')
    expect(page).to have_content("$4.00")
  end
end
