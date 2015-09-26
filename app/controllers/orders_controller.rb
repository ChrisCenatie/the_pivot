class OrdersController < ApplicationController
  before_action :find_order, only: [:show]

  def create
    if current_user
      if cart.data != {}
        order = OrderCreator.new(cart.data, current_user).order
        session[:cart] = nil
        redirect_to order
      else
        redirect_to cart_path
        flash[:errors] = "Cart it empty! Fill it up with some goodies"
      end
    else
      flash[:errors] = "Create an account to complete your order"
      redirect_to login_path
    end
  end

  def show 
    @order_items = @order.order_items
  end

  def index
    if current_user
      @orders = Order.where(user_id: current_user.id)
    else
      redirect_to login_path
    end
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
