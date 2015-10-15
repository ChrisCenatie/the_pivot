require "rails_helper"

RSpec.feature "user can view completed order" do

  def create_order
    visit category_items_path(@category)

    click_on("Add Fries")
    click_on("Add Soda")
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
    input_user_info!
    click_on("Check Out")
  end

  before(:each) do
    create_user!
    create_category!
    create_item!
    create_item1!
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
    expect(page).to have_content("$9.00")
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
