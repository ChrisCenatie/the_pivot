class AdminController < ApplicationController
  before_action :require_admin

  def require_admin
    if current_user && current_user.admin?
      true
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
end
