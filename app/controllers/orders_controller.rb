class OrdersController < ApplicationController
  before_action :find_order, only: [:show, :update]

  def create
    cart_empty?("Cart is empty! Fill it up with some goodies") or return
    not_logged_in?("Create an account to complete your order") or return
    no_address?("Please enter your address to complete your order") or return
    creator = OrderCreator.new(cart.data, current_user)
    order = creator.order
    skip_stripe?(order)
    already_paid?(order) or return
    total_price = creator.total_price

    redirect_to new_charge_path(order_id: order.id, order_price: total_price, cart_data: cart.data)
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

  def cart_empty?(message)
    if cart.data == {}
      flash[:errors] = message
      redirect_to cart_path
    end
    return true
  end

  def no_address?(message)
    if !current_user.address
      flash[:errors] = message
      redirect_to edit_user_path(current_user) and return
    end
    return true
  end

  def skip_stripe?(order)
    if ENV["RAILS_ENV"] == "test"
      order.update(status: 1)
    end
  end

  def already_paid?(order)
    if order.paid?
      OrderCompleter.new(order, cart).create_order_items
      session[:cart] = nil
      redirect_to order and return
    end
    return true
  end
end
