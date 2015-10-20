class Farmers::ItemsController < Farmers::FarmersBaseController
  def index
    if current_farmer.active?
      @items = current_farmer.items
    else
      flash[:errors] = "Farm not active!"
      redirect_to farmers_path
    end
  end
end
