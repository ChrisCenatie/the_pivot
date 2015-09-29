class CartItemsController < ApplicationController
  def create
    cart.add_item(params[:item_id])
    session[:cart] = cart.data
    flash[:notice] = "Successfully added #{Item.find(params[:item_id]).name} to cart"
    redirect_to items_path
  end

  def update
    cart.add_item(params[:item_id])
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def destroy
    cart.remove_item(params[:item_id])
    session[:cart] = cart.data
    redirect_to cart_path
  end

  def index
  end
end
