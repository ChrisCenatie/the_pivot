class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :update]

  def create
    not_logged_in?("Create an account to complete your order") or return
    no_address?("Please enter your address to complete your order") or return
    order_creator = OrderCreator.new(cart.data, current_user)
    if params[:order_id]
      order = Order.find(params[:order_id])
    else
      order = order_creator.order
    end
    total_price = order_creator.total_price
    not_paid?(order, total_price, cart.data, "Please enter a credit card to complete your order") or return

      if cart.data != {}
        order_creator.create_order_items
        session[:cart] = nil
        redirect_to order
      else
        flash[:errors] = "Cart is empty! Fill it up with some goodies"
        redirect_to cart_path
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

  def update
    @order.update(status: params[:status])
    redirect_to admin_dashboard_path
  end

  private

  def find_order
    @order = Order.find(params[:id])
  end
end
