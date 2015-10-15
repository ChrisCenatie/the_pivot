require "rails_helper"

RSpec.feature "guest user" do

  scenario "cannot view another users data" do
    create_user!
    visit user_path(user)
    expect(page.status_code).to eq(401)
  end

  scenario "cannot view administrator functionality" do
    visit admin_dashboard_path

    expect(page.status_code).to eq(404)
  end
end
