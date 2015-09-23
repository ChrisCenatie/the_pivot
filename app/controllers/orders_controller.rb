class OrdersController < ApplicationController
  def create
    if current_user
      # happy path for orders goes here
    else
      flash[:errors] = "Create an account to complete your order"
      redirect_to login_path
    end

  end
end
