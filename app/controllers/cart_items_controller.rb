class CartItemsController < ApplicationController
  def create
    cart.add_item(params[:item_id])
    session[:cart] = cart.data
    flash[:notice] = "Successfully added #{Item.find(params[:item_id]).name} to cart"
    redirect_to category_items_path(Category.find(params[:category_id]))
  end

  def update
    cart.add_item(params[:item_id])
    session[:cart] = cart.data
    flash[:notice] = "Successfully added #{Item.find(params[:item_id]).name} to cart"
    redirect_to cart_path
  end

  def destroy
    cart.remove_item(params[:item_id])
    session[:cart] = cart.data
    flash[:notice] = "Successfully removed #{Item.find(params[:item_id]).name} from cart"
    redirect_to cart_path
  end

  def index
  end
end
