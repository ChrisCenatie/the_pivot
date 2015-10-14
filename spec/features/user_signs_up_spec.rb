require "rails_helper"

RSpec.feature "user signs up" do

  scenario "with correct credentials" do
    visit root_path
    click_link("Sign up")

    expect(page).to have_content("Sign up")
    expect(current_path).to eq(new_user_path)

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(page).to have_content("Hello, Justin")
    expect(current_path).to eq(dashboard_path)
  end

  scenario "with invalid credentials" do
    visit root_path
    click_link("Sign up")

    fill_in "Email", with: "Justin@example.com"
    click_button "Create Account"

    expect(page).to have_content("Invalid login attempt")
    expect(current_path).to eq(new_user_path)
  end

  scenario "with an email already in use by another user" do
    User.create(email: "Justin@example.com", password: "password")

    visit root_path
    click_link("Sign up")

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("That email address is taken")
  end
end
