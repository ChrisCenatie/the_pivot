require "rails_helper"

RSpec.feature "user can view completed order" do

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
    enter_address
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

  before(:each) do
    User.create(email: "justin@example.com", password: "password")
    @category = Category.create(name: "Meals")
    @item = Item.create(name: 'Fries', description: 'Fo Free', price: 4, category_id: @category.id)
    Item.create(name: 'Burger', description: 'for a rabbi', price: 3.50, category_id: @category.id)
  end

  scenario "after clicking checkout and then logging in" do
    create_order

    order = Order.last
    expect(current_path).to eq(order_path(order))
  end

  scenario "show page, after completing the order and looking at all of their past orders" do
    create_order

    click_on("Past orders")
    expect(current_path).to eq(orders_path)

    order = Order.last

    click_on("Order #{order.id}")
    expect(current_path).to eq(order_path(order))

    expect(page).to have_content("Fries")
    expect(page).to have_content("2")
    expect(page).to have_content("$8.00")
    expect(page).to have_content("Ordered")
    expect(page).to have_content("$11.50")
    expect(page).to have_content("#{order.date}")

    click_on("Fries")
    expect(current_path).to eq(category_item_path(@category, Item.find_by(name: "Fries")))
  end

  scenario "and cart is empied after checking out" do
    create_order
    click_on "Cart"

    expect(page).to_not have_content("Fries")
    expect(page).to_not have_content("Burger")
  end
end
