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

  before(:each) do
    login_user!
    @category = Category.create(name: "Meals")
    User.create(email: "justin@example.com", password: "password")
    farmer = Farmer.create(name: "McDonald")
    @item = Item.create(name: 'Fries',
                        description: 'Fo Free',
                        price: 200,
                        category_id: @category.id,
                        farmer_id: farmer.id)
    Item.create(name: 'Burger',
                description: 'for a rabbi',
                price: 650,
                category_id: @category.id,
                farmer_id: farmer.id)
    @user = User.first
  end

  scenario "and see past orders" do
    create_order!
    order = Order.last

    click_on("Past orders")

    expect(current_path).to eq(orders_path)
    expect(page).to have_content("Order #{order.id}")
  end

  scenario "and change their email" do
    click_on("Edit Profile")
    fill_in("#{@user.email}", with: "ryan@example.com")
    click_on("Update Email")

    expect(User.first.email).to eq("ryan@example.com")
  end

  scenario "and change their address" do
    click_on("Edit Profile")
    fill_in("Street", with: "1501 Blake St")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80202")
    click_on("Update Address")

    expect(User.first.full_address).to eq("1501 Blake St  Denver, CO 80202")
  end

  scenario "and change their name" do
    click_on("Edit Profile")
    fill_in("user_and_address[first_name]", with: "Ryan")
    fill_in("user_and_address[last_name]", with: "Example")
    click_on("Update Name")

    expect(User.first.full_name).to eq("Ryan Example")
  end

  scenario "and change their password" do
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

    expect(page).to have_content("Hello, Justin")
  end
end
