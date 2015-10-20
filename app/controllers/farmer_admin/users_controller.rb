class FarmerAdmin::UsersController < FarmerAdminController
  def show
    if session[:filter]
      @orders = Order.where(status: session[:filter]).order(:id)
    else
      @orders = Order.all.order(:id)
    end
  end

  def update
    session[:filter] = params[:filter]
    redirect_to farmer_admin_dashboard_path
  end
end
