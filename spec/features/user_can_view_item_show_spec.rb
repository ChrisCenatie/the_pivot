require 'rails_helper'

describe 'the item show', type: :feature do
  let(:item) { Item.create(name: "Soda", description: "Teh bubbles", price:100) }
  it 'can show one item' do
    visit "/items/#{item.id}"
    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('100')
  end
end
