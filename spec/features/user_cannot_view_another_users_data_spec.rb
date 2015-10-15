require "rails_helper"

RSpec.feature "user cannot view another users data" do

  scenario "by visiting another users show route" do
    create_user!
    create_user2!
    visit root_url
    click_on("Login")
    fill_in("Email", with: "justin@example.com")
    fill_in("Password", with: "password")
    within(:css, "div#login_form") do
      click_on("Login")
    end
    visit user_path(@user2)

    expect(page.status_code).to eq(401)
  end
end
