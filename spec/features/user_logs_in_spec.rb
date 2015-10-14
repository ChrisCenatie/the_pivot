require "rails_helper"

RSpec.feature "user logs in" do

  before(:each) { create_user! }

  scenario "with valid credentials" do
    visit root_path
    click_link("Login")

    expect(page).to have_content("Login")
    expect(current_path).to eq(login_path)

    fill_in "Email", with: "justin@example.com"
    fill_in "Password", with: "password"
    click_button("Login")

    expect(page).to have_content("Hello, Justin")
    expect(current_path).to eq("/users/#{user.id}")
  end

  scenario "with invalid credentials" do
    visit root_path
    click_link("Login")
    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "passwor"
    click_button "Login"

    expect(page).to_not have_content("Hello, Justin")
    expect(current_path).to eq(login_path)
  end

  scenario "login persists across pages" do
    visit root_path
    click_link("Login")
    fill_in "Email", with: "justin@example.com"
    fill_in "Password", with: "password"
    click_button("Login")
    visit category_items_path(category)

    visit user_path(user.id)

    expect(current_path).to eq("/users/#{user.id}")
  end

  scenario "cannot view profile if not logged in" do
    visit user_path(user.id)

    expect(page.status_code).to eq(401)
    expect(page).to have_content
      ("You are not authorized to view this page")
  end
end
