require "rails_helper"

RSpec.feature "guest user" do
  before(:each) do
    @user = User.create(email: "justin@example.com", password: "password")
  end

  scenario "cannot view another users data" do
    visit user_path(@user)
    expect(page.status_code).to eq(401)
  end
end
