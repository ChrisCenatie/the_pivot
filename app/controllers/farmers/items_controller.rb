class Farmers::ItemsController < Farmers::FarmersBaseController
  def index
    @items = current_farmer.items
  end
end
