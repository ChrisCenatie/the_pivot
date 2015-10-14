require "rails_helper"

RSpec.feature "all users" do

  scenario "can see the splash page" do
    visit root_path


    expect(page).to have_content("Fast flying farm")
    expect(page).to have_content("Login")
    expect(page).to have_content("Sign up")
  end
end
