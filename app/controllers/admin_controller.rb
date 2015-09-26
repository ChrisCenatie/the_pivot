class AdminController < ApplicationController

  before_action :is_admin?

  def is_admin?
    current_user.admin?
  end

end
