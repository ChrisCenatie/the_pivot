class OrdersController < ApplicationController
  def create
    user = User.find_by(email: params[:session][:email])

    if user
      # happy path for orders goes here
    else
      flash[:errors] = "Create an account to complete your order"
      redirect_to login_path
    end

  end
end
