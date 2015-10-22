class FarmerAdmin::OrdersController < FarmerAdminController

  def update
    order = Order.find(order_params[:id])
    order_items = order.order_items
    farmer = current_user.farmer
    order_items.each do |order_item|
      order_item.delete if farmer.items.include?(order_item.item)
    end
    FarmerOrder.find_by(order_id: order_params[:id],
                        farmer_id: farmer.id).delete
    flash[:notice] = "Order has been cancelled!"
    redirect_to farmer_admin_dashboard_path
  end

  private

    def order_params
      params.permit(:id)
    end
end
