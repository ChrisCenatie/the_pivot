require "rails_helper"

RSpec.feature "non farmer admin cannot access farmer admin pages" do

  def cannot_visit_farmer_admin_pages
    visit "/farmer_admin/dashboard"
    page.status_code.should eq(404)
    visit "/farmer_admin/users/new"
    page.status_code.should eq(404)
    visit "/farmer_admin/farmers/1/edit"
    page.status_code.should eq(404)
  end

  scenario "as guest" do
    cannot_visit_farmer_admin_pages
  end

  scenario "as registered user" do
    login_user!
    cannot_visit_farmer_admin_pages
  end

  scenario "as registered admin" do
    login_admin!
    cannot_visit_farmer_admin_pages
  end



end
