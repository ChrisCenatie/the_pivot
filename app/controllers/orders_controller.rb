class OrdersController < ApplicationController
  before_action :find_order, only: [:show]

  def create
    if current_user
      unless cart.data == {}
       order_creator = OrderCreator.new(cart.data, current_user)
       order_creator.create_order_items

       order = order_creator.order

       redirect_to order
      else
        redirect_to cart_path
      end
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
