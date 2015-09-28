require "rails_helper"

RSpec.feature "admin can" do

  before(:each) do
    category = Category.create(name: "Meals")
  Item.create(category_id: category.id, name: "Roast Chicken", description: "Just like grandma's", price: "11.50")
  end

#
#  after(:all) do
#    Capybara.use_default_driver 
#  end

  def create_admin
    User.create(email: "admin@example.com", password: "password", role: 3)
  end

  def admin_logs_in
    create_admin
    visit login_path
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  scenario "edit items with valid params" do
    create_admin
    admin_logs_in
    visit items_path

    expect(page).to have_content("Delete")
    click_on("Delete")

    expect(current_path).to eq(items_path)

    expect(page).to_not have_content("Roast Chicken")
    expect(page).to_not have_content("grandma")
  end
end
