require "rails_helper"

RSpec.feature "user can receive a confirmation text message" do
  def create_order
    visit category_items_path(@category)

    click_on("Add Fries")
    click_on("Add Burger")
    click_on("Cart")
    within(:css, "div#item_#{@item.id}") do
      click_on("+")
    end
    click_on("Check Out")

    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
    click_on("Check Out")
    enter_additional_information
  end

  def enter_additional_information
    fill_in("First Name", with: "Josha")
    fill_in("Last Name", with: "Mejia")
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    fill_in("Phone Number", with: "8622029173")
    click_on("Update")
    click_on("Check Out")
  end

  before(:each) do
    farmer = Farmer.create(name: "McDonald")
    User.create(email: "justin@example.com", password: "password")
    @category = Category.create(name: "Meals")
    @item = Item.create(name: 'Fries',
                        description: 'Fo Free',
                        price: 4,
                        category_id: @category.id,
                        farmer_id: farmer.id)
    Item.create(name: 'Burger',
                description: 'for a rabbi',
                price: 350,
                category_id: @category.id,
                farmer_id: farmer.id)
  end

  scenario "after placing order" do
    create_order

    expect(Order.last.notification).to eq("sent")
  end
end
