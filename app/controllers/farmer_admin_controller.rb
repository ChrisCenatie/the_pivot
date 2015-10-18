class FarmerAdminController < ApplicationController

  before_action :require_farmer_admin

  def require_farmer_admin
    if current_user && current_user.farmer_admin?
      true
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end

end
