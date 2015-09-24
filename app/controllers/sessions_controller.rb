class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      if !cart.data == {}
       order_creator = OrderCreator.new(cart.data, user)
       order_creator.create_order_items

       order = order_creator.order

       redirect_to order
      else
        redirect_to user
      end
    else
      flash.now[:errors] = "Invalid credentials, please try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out"
    redirect_to root_path
  end
end
