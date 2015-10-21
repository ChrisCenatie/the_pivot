class FarmerAdmin::OrdersController < FarmerAdminController

  def update
    session[:filter] = params[:filter]
    redirect_to farmer_admin_dashboard_path
  end

end
