require "rails_helper"

RSpec.feature "user can view past orders" do

  before(:each) do
    @category = Category.create(name: "Meals")
    Item.create(category_id: @category.id, name: "Burger",
        description: "For a rabbi", price: 2)
    Item.create(category_id: @category.id, name: "Steak",
        description: "Fo Free", price: 4)

    @user = User.create(email: "david@example.com", password: "password")
    @user2 = User.create(email: "mike@example.com", password: "password")
  end

  def create_order
    visit login_path
    fill_in("Email", with: "david@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
    visit category_items_path(@category)
    click_on("Add Steak")
    click_on("Cart")
    click_on("Check Out")
    enter_address
    @order1 = Order.last
  end

  def enter_address
    fill_in("First Name", with: "Josha")
    fill_in("Last Name", with: "Mejia")
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
    click_on("Check Out")
  end

  scenario "when they visit /orders" do
    create_order

    order = Order.last
    expect(current_path).to eq(order_path(order))
    visit orders_path

    expect(current_path).to eq(orders_path)
    expect(@user.orders.count).to eq(1)

    visit category_items_path(@category)
    click_on("Add Burger")
    click_on("Cart")
    click_on("Check Out")

    visit orders_path
    order = Order.last
    expect(page).to have_content("Order #{order.id}")
    expect(page).to have_content("#{order.created_at}")
    expect(page).to have_content("#{order.total_price}")
  end

  scenario "for only their own cart" do
    create_order
    click_on("Logout")

    visit login_path
    fill_in("Email", with: "mike@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    visit category_items_path(@category)
    click_on("Add Burger")
    click_on("Cart")
    click_on("Check Out")
    enter_address
    visit orders_path
    @order2 = Order.last

    expect(page).to have_content("Order #{@order2.id}")
    expect(page).to_not have_content("Order #{@order1.id}")
  end

  scenario "only if logged in" do
    visit orders_path
    expect(current_path).to eq(login_path)
  end
end
