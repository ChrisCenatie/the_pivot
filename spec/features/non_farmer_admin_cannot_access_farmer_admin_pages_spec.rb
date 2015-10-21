require "rails_helper"

RSpec.feature "non farmer admin cannot access farmer admin pages" do

  scenario "as guest" do
    visit "/farmer_admin/dashboard"
    page.status_code.should eq(404)
    visit "/farmer_admin/users/new"
    page.status_code.should eq(404)
    visit "/farmer_admin/farmers/1/edit"
    page.status_code.should eq(404)
  end

  scenario "as registered user" do
    login_user!
    visit "/farmer_admin/dashboard"
    page.status_code.should eq(404)
    visit "/farmer_admin/users/new"
    page.status_code.should eq(404)
    visit "/farmer_admin/farmers/1/edit"
    page.status_code.should eq(404)
  end

  scenario "as registered admin" do
    login_admin!
    visit "/farmer_admin/dashboard"
    page.status_code.should eq(404)
    visit "/farmer_admin/users/new"
    page.status_code.should eq(404)
    visit "/farmer_admin/farmers/1/edit"
    page.status_code.should eq(404)
  end



end
