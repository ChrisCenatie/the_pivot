class Admin::FarmersController < AdminController

  def index
    @farmers = Farmer.all
  end

  def update
    farmer = Farmer.find(params[:id])
    farmer.update(farmer_params)
    flash[:notice] = "Updated #{farmer.name}'s status"
    redirect_to admin_farmers_path
  end

  private

  def farmer_params
    params.permit(:active)
  end

end
