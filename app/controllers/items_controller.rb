class ItemsController < ApplicationController
  before_action :find_item, only: [:show, :edit, :update, :destroy]
  before_action :find_category, only: [:show, :index, :new]

  def index
    @items = Item.where(status: "Active").order(:id)
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "Successfully created item"
      redirect_to category_items_path(@item.category)
    else
     render :new
    end
  end

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "Successfully Updated"
      redirect_to category_items_path(@item.category)
    else
      flash[:errors] = "Invalid update params"
      redirect_to edit_item_path(@item)
    end
  end

  def destroy
    @item.update(status: 1)
    redirect_to category_items_path(Category.find(params[:category_id]))
  end

  def new
    @item = Item.new
  end

  private

  def find_item
    @item = Item.find(params[:id])
  end

  def find_category
    @category = Category.find(params[:category_id]) if params[:category_id]
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :category_id, :image_url)
  end
end
