class CartItemsController < ApplicationController
  def create
    cart.add_item(item.id)
    session[:cart] = cart.data
    flash[:notice] = "Successfully added #{item.name} to cart"
    redirect_to category_path(category)
  end

  def update
    cart.add_item(item.id)
    session[:cart] = cart.data
    flash[:notice] = "Successfully added #{item.name} to cart"
    redirect_to redirect_path 
  end

  def destroy
    cart.remove_item(item.id)
    session[:cart] = cart.data
    flash[:notice] = "Successfully removed #{item.name} from cart"
    redirect_to redirect_path 
  end

  def index
  end

  private

  def redirect_path
    if previous_path == category_path(item.category, item)
       previous_path 
    else
      cart_path
    end
  end

  def item
    Item.find(params[:item_id])
  end

  def category
    if params[:category_id]
      Category.find(params[:category_id])
    else
      item.category
    end
  end

end
