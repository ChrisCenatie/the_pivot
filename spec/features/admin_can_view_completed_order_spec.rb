require "rails_helper"

RSpec.feature "admin can view completed order" do
  before(:each) do
    User.create(email: "admin@example.com", password: "password", role: 3)
    @user = User.create(email: "justin@example.com", password: "password")
    Address.create(user_id: @user.id, street_address: "1510 Blake street",
      apt: "basement", city: "Denver", state: "CO", zip_code: "80110")
    @order = Order.create(user_id: @user.id, status: 2)
    @category = Category.create(name: "Meals")
    @item = Item.create(category_id: @category.id, name: "Roast Chicken", description: "Just like grandma's", price: "11.50")
    @order_item = OrderItem.create(order_id: @order.id, quantity: 5, price: @item.price,
      item_id: @item.id)
  end

  def admin_logs_in
    visit login_path
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  scenario "when authorized" do
    admin_logs_in
    visit order_path(@order)

    expect(page).to have_content(@order.date)
    expect(page).to have_content(@user.full_name)
    expect(page).to have_content(@user.address.street_address)
    expect(page).to have_content(@order_item.quantity)
    expect(page).to have_content(@item.price)
    expect(page).to have_content(@order.total_price)
    expect(page).to have_content(@order_item.quantity * @order_item.price)
    expect(page).to have_content(@order.status.humanize)
    expect(page).to have_content(@item.name)

    click_on(@item.name)

    expect(current_path).to eq(category_item_path(@category, @item))
  end
end
