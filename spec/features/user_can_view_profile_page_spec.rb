require "rails_helper"

RSpec.feature "user can view profile page" do
  def create_order
    visit category_items_path(@category)

    click_on("Add Fries")
    click_on("Add Burger")
    click_on("Cart")
    within(:css, "div#item_#{@item.id}") do
      click_on("+")
    end
    click_on("Check Out")
  end

  def login_user
    visit login_path

    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  def user_info
    fill_in("user_and_address[first_name]", with: "Justin")
    fill_in("user_and_address[last_name]", with: "Example")
    fill_in("Street", with: "1501 Blake St")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80202")
    click_on("Update")
  end

  before(:each) do
    @category = Category.create(name: "Meals")
    User.create(email: "justin@example.com", password: "password")
    @item = Item.create(name: 'Fries', description: 'Fo Free', price: 4, category_id: @category.id)
    Item.create(name: 'Burger', description: 'for a rabbi', price: 3.5, category_id: @category.id)
    @user = User.first
  end

  scenario "and see past orders" do
    login_user
    create_order
    user_info
    click_on("Check Out")

    click_on("Past orders")
    order = Order.last

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Order #{order.id}")
  end

  scenario "and change their email" do
    login_user
    click_on("Edit Profile")
    fill_in("#{@user.email}", with: "ryan@example.com")
    click_on("Update Email")

    expect(User.first.email).to eq("ryan@example.com")
  end

  scenario "and change their address" do
    login_user
    click_on("Edit Profile")
    fill_in("Street", with: "1501 Blake St")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80202")
    click_on("Update Address")

    expect(User.first.full_address).to eq("1501 Blake St  Denver, CO 80202")
  end

  scenario "and change their name" do
    login_user
    click_on("Edit Profile")
    fill_in("user_and_address[first_name]", with: "Ryan")
    fill_in("user_and_address[last_name]", with: "Example")
    click_on("Update Name")

    expect(User.first.full_name).to eq("Ryan Example")
  end

  scenario "and change their password" do
    login_user
    click_on("Edit Profile")

    fill_in("Enter New Password", with: "asdf")
    click_on("Update Password")
    click_on("Logout")
    click_on("Login")
    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "asdf")
    within(:css, "div#login_form") do
      click_on("Login")
    end

    expect(page).to have_content("Hello, justin")
  end
end
