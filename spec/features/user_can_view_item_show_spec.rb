require 'rails_helper'

describe 'the item show', type: :feature do

  it 'can show one item' do
    visit '/items/1'
    expect(page).to have_content('Soda')
    expect(page).to have_content('Teh bubbles')
    expect(page).to have_content('100')
  end
end
    
