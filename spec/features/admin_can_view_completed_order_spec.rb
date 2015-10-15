require "rails_helper"

RSpec.feature "admin can view completed order" do
  before(:each) do
    Address.create(user_id: user.id, street_address: "1510 Blake street",
      apt: "basement", city: "Denver", state: "CO", zip_code: "80110")
    @order = Order.create(user_id: user.id, status: 2)
    @order_item = OrderItem.create(order_id: @order.id, quantity: 5, price: item.price,
      item_id: item.id)
  end

  scenario "when authorized" do
    login_admin!
    visit order_path(@order)

    expect(page).to have_content(@order.date)
    expect(page).to have_content(user.full_name)
    expect(page).to have_content(user.address.street_address)
    expect(page).to have_content(@order_item.quantity)
    expect(page).to have_content(item.price)
    expect(page).to have_content(@order.total_price)
    expect(page).to have_content(@order_item.quantity * @order_item.price)
    expect(page).to have_content(@order.status.humanize)
    expect(page).to have_content(item.name)

    click_on(item.name)

    expect(current_path).to eq(category_item_path(category, item))
  end
end
