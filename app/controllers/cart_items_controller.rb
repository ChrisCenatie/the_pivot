class CartItemsController < ApplicationController

  def create
    add_item_to_cart(item)
    redirect_to category_path(category)
  end

  def update
    add_item_to_cart(item)
    redirect_to cart_path
  end

  def destroy
    cart.remove_item(item.id)
    session[:cart] = cart.data
    flash[:notice] = "Successfully removed #{item.name} from cart"
    redirect_to cart_path
  end

  def index
  end

    private

    def add_item_to_cart(item)
      cart.add_item(item.id)
      session[:cart] = cart.data
      flash[:notice] = "Successfully added #{item.name} to cart"
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
