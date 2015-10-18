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
    # This option will default to `true` in RSpec 4. It makes the `description`
    # and `failure_message` of custom matchers include text for helper methods
    # defined using `chain`, e.g.:
    #     be_bigger_than(2).and_smaller_than(4).description
    #     # => "be bigger than 2 and smaller than 4"
    # ...rather than:
    #     # => "be bigger than 2"
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # rspec-mocks config goes here. You can use an alternate test double
  # library (such as bogus or mocha) by changing the `mock_with` option here.
  config.mock_with :rspec do |mocks|
    # Prevents you from mocking or stubbing a method that does not exist on
    # a real object. This is generally recommended, and will default to
    # `true` in RSpec 4.
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

  def login_admin!
    create_admin!
    visit login_path
    fill_in("Email", with: "admin@example.com")
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
                          phone_number: "555-555-5555")
  end

  def user2
    @user2 ||= User.create(email: "george@example.com",
                password: "password", first_name: "George",
                last_name: "Clooney", phone_number: "555-555-5555")
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
    fill_in("First Name", with: "Josha")
    fill_in("Last Name", with: "Mejia")
    fill_in("Phone Number", with: "9292266613")
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
    @farmer ||= Farmer.create(name: "George")
  end

  def farmer2
    @farmer2 ||= Farmer.create(name: "McDonald")
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


# The settings below are suggested to provide a good initial experience
# with RSpec, but feel free to customize to your heart's content.
=begin
  # These two settings work together to allow you to limit a spec run
  # to individual examples or groups you care about by tagging them with
  # `:focus` metadata. When nothing is tagged with `:focus`, all examples
  # get run.
  config.filter_run :focus
  config.run_all_when_everything_filtered = true

  # Allows RSpec to persist some state between runs in order to support
  # the `--only-failures` and `--next-failure` CLI options. We recommend
  # you configure your source control system to ignore this file.
  config.example_status_persistence_file_path = "spec/examples.txt"

  # Limits the available syntax to the non-monkey patched syntax that is
  # recommended. For more details, see:
  #   - http://myronmars.to/n/dev-blog/2012/06/rspecs-new-expectation-syntax
  #   - http://www.teaisaweso.me/blog/2013/05/27/rspecs-new-message-expectation-syntax/
  #   - http://myronmars.to/n/dev-blog/2014/05/notable-changes-in-rspec-3#new__config_option_to_disable_rspeccore_monkey_patching
  config.disable_monkey_patching!

  # Many RSpec users commonly either run the entire suite or an individual
  # file, and it's useful to allow more verbose output when running an
  # individual spec file.
  if config.files_to_run.one?
    # Use the documentation formatter for detailed output,
    # unless a formatter has already been configured
    # (e.g. via a command-line flag).
    config.default_formatter = 'doc'
  end

  # Print the 10 slowest examples and example groups at the
  # end of the spec run, to help surface which specs are running
  # particularly slow.
  config.profile_examples = 10

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = :random

  # Seed global randomization in this process using the `--seed` CLI option.
  # Setting this allows you to use `--seed` to deterministically reproduce
  # test failures related to randomization by passing the same `--seed` value
  # as the one that triggered the failure.
  Kernel.srand config.seed
=end
end
