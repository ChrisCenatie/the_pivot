class FarmerAdmin::FarmersController < FarmerAdminController
  def edit
    @farmer = Farmer.find(current_user.farmer.id)
  end

  def update
    @farmer = Farmer.find(current_user.farmer.id)
    if @farmer.update(farmer_params)
      flash[:notice] = "Successfully updated informaiton"
      redirect_to farmer_admin_dashboard_path
    else
      flash[:errors] = @farmer.errors.full_messages
      redirect_to edit_farmer_admin_farmer_path
    end
  end

  private

  def farmer_params
    params.require(:farmer).permit(:name, :image_url)
  end
end
