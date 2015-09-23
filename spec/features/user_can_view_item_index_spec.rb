require 'rails_helper'

describe 'the item view', type: :feature do

  it 'shows the items' do
    visit items_path
    
    expect(page).to have_content('Fries')
    expect(page).to have_content('Fo Free')
    expect(page).to have_content(100)
  end
end