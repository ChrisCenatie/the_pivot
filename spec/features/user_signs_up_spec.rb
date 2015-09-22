require 'rails_helper'

RSpec.feature "user signs up" do
  before(:each) do

  end

  scenario "with correct credentials" do
    visit new_user_path
    fill_in "Email", with: "Justin@example.com"
    fill_in "Password", with: "password"
    click_button "Create Account"

    expect(page).to have_content("Justin@example.com")

    user = User.find_by(email: "Justin@example.com")

    expect(current_path).to eq("/users/#{user.id}")
  end

end
