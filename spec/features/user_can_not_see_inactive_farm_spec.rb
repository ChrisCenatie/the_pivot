require "rails_helper"

RSpec.feature "user cannot see inactive farmers" do

  before(:each) do
    create_farmers!
    farmer.update(active: false)
    login_user!
  end

  scenario "user visits farmers index" do
    visit "/farmers"

    expect(page).to_not have_content("George")
    expect(page).to have_content("McDonald")
  end

  scenario "user visits farmers items index" do
    visit "/george/items"

    expect(current_path).to eq(farmers_path)
    expect(page).to have_content("Farm not active!")
  end

  scenario "user visits category items index" do
    create_item!
    create_item1!
    visit category_path(category)
    
    expect(page).to have_content("Soda")
    expect(page).to_not have_content("Fries")
    expect(page).to_not have_content("George")
  end
end
