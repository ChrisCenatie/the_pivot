require 'rails_helper'

describe 'the item view', type: :feature do

  it 'shows the items' do
    Item.create(name: 'Fries', description: 'Fo Free', price: 400)
    visit root_path

    visit items_path

    expect(page).to have_content('Fries')
    expect(page).to have_content('Fo Free')
    expect(page).to have_content(400)
  end
end
