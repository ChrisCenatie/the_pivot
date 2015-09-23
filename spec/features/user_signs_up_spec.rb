require "rails_helper"

RSpec.feature "user signs up" do
  let(:user) { User.find_by(email: "Justin@example.com") }

  scenario "with correct credentials" do
    visit root_path
    click_link("Sign up")

    expect(page).to have_content("Sign up")
    expect(current_path).to eq(new_user_path)

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(page).to have_content("Justin@example.com")
    expect(current_path).to eq("/users/#{user.id}")
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
    visit root_path
    click_link("Sign up")

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    visit root_path
    click_link("Sign up")

    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(current_path).to eq(new_user_path)
    expect(page).to have_content("That email address is taken")
  end
end
