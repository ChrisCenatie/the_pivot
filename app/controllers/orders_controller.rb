class OrdersController < ApplicationController
  before_action :find_order, only: [:show]

  def create
    if current_user
      byebug
      redirect_to order
    else
      flash[:errors] = "Create an account to complete your order"
      redirect_to login_path
    end
  end

  def show
    @order_items = @order.order_items
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
