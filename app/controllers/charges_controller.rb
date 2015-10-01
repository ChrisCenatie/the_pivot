class ChargesController < ApplicationController
  def new
    @order = Order.find(params[:order_id])
    @items_by_quantity = items_by_quantity(params[:cart_data])
    @total_price = params[:order_price]
    @price_in_pennies = (params[:order_price].to_f * 100).to_i
    if ENV["RAILS_ENV"] != 'test' 
      @delivery_time = DeliveryTime.new(@order).time
    end
  end

  def create
    @amount = params[:price_in_pennies]

    customer = Stripe::Customer.create(
      email: "example@stripe.com",
      card: params[:stripeToken]
    )

    Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: "Faster Food customer",
      currency: "usd"
    )

    order = Order.find(params[:order_id])
    order.update(status: 1)
    OrderCompleter.new(order, cart).process_order
    session[:cart] = nil
    redirect_to order

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to charges_path
  end


  def items_by_quantity(cart_data)
    items_by_quantity = {}
    cart_data.each do |item_id, quantity|
      items_by_quantity[Item.find(item_id)] = quantity
    end
    items_by_quantity
  end
end
