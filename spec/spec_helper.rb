RSpec.configure do |config|
  require 'simplecov'
  SimpleCov.start 'rails'

  require 'capybara/rspec'
  config.include Capybara::DSL

  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  def create_admin!
    User.create(email: "admin@example.com",
                password: "password",
                first_name: "null",
                last_name: "null",
                phone_number: "null",
                role: 3)
  end

  def create_farmer_admin!
    User.create(email: "farmer@example.com",
                password: "password",
                role: 2,
                farmer_id: farmer.id,
                first_name: "Old",
                last_name: "McDonald",
                phone_number: "null")
  end

  def login_admin!
    create_admin!
    visit login_path
    fill_in("Email", with: "admin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  def login_farmer_admin!
    create_farmer_admin!
    visit login_path
    fill_in("Email", with: "farmer@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  def create_user!
    user
  end

  def create_user2!
    user2
  end

  def login_user!
    create_user!

    visit login_path

    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  def login_user2!
    create_user2!

    visit login_path

    fill_in("Email", with: "george@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
  end

  def user
    @user ||= User.create(email: "justin@example.com",
                          password: "password",
                          first_name: "Justin",
                          last_name: "Beiber",
                          phone_number: "9292266613")
  end

  def user2
    @user2 ||= User.create(email: "george@example.com",
                password: "password", first_name: "George",
                last_name: "Clooney", phone_number: "9292266613")
  end

  def create_order!
    login_user!
    create_item!
    create_item1!
    visit category_items_path(@category)
    click_on("Add Fries")
    click_on("Add Soda")
    click_on("Cart")
    within(:css, "div#item_#{item.id}") do
      click_on("+")
    end
    click_on("Check Out")
    input_user_info!
    click_on("Check Out")
  end

  def input_user_info!
    fill_in("Street", with: "1510 Blake Street")
    fill_in("City", with: "Denver")
    fill_in("State", with: "CO")
    fill_in("Zip Code", with: "80010")
    click_on("Update")
  end

  def order
    @order ||= Order.create(user_id: user.id)
  end

  def farmer
    @farmer ||= Farmer.create(name: "George", active: true)
  end

  def farmer2
    @farmer2 ||= Farmer.create(name: "McDonald", active: true)
  end

  def farmer3
    @farmer3 ||= Farmer.create(name: "Reginald")
  end

  def farmer4
    @farmer4 ||= Farmer.create(name: "Jebediah")
  end

  def create_farmers!
    farmer
    farmer2
  end

  def create_new_farmers!
    farmer3
    farmer4
  end

  def create_category!
    category
  end

  def create_category2!
    category2
  end

  def category
    @category ||= Category.create(name: "Meals")
  end

  def category2
    @category2 ||= Category.create(name: "MoarMeals!")
  end

  def create_item!
    item
  end

  def item
    @item ||= Item.create(name: "Fries",
                          description: "Yummy",
                          price: 4.00,
                          category_id: category.id,
                          farmer_id: farmer.id)
  end

  def create_item1!
    item1
  end

  def item1
    @item1 ||= Item.create(name: 'Soda',
                           description: 'Teh bubbles',
                           price: 1.00,
                           category_id: category.id,
                           farmer_id: farmer2.id)
  end

  def create_item2!
    item2
  end

  def item2
    @item2 ||= Item.create(name: 'Burger',
                           description: 'beef',
                           price: 8.50,
                           category_id: category2.id,
                           farmer_id: farmer.id)
  end
end
