class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update]

  def index
    @items = Item.all
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
     redirect_to previous_path
    else
     render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "Successfully Updated"
      redirect_to items_path
    else
      flash[:errors] = "Invalid update params"
      redirect_to edit_item_path(@item)
    end
  end

  def new
    @item = Item.new
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :image_url)
  end
end
