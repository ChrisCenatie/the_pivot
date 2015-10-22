class FarmerAdmin::OrdersController < FarmerAdminController

  def update
    order = Order.find(order_params[:id])
    farmer = current_user.farmer
    FarmerAdminOrders.remove_order_items(order, farmer)
    FarmerAdminOrders.remove_farmer_order(farmer, order_params)
    flash[:notice] = "Order has been cancelled!"
    redirect_to farmer_admin_dashboard_path
  end

  private

    def order_params
      params.permit(:id)
    end
end
