class ItemsController < ApplicationController
  before_action :find_category, only: [:show, :index]

  def index
    @items = Item.where(status: "Active").order(:id)
  end

  def show
    @item = Item.find(params[:id])
  end

    private

    def find_category
      @category = Category.find(params[:category_id]) if params[:category_id]
    end

end
