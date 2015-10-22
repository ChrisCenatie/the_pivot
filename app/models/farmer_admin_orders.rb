class FarmerAdminOrders

  def self.order_total(order, farmer)
    order_items = order.order_items
    price_quantities = order_items.map do |order_item|
      if farmer.items.include?(Item.find(order_item.item_id))
        order_item.quantity * order_item.price
      else
        0
      end
    end
    price_quantities.reduce(:+)
  end

  def self.items(order, farmer)
    order_items = order.order_items
    items = []
    order_items.each do |order_item|
      item = Item.find(order_item.item_id)
      items << item.name if farmer.items.include?(item)
    end
    items
  end

  def self.farmer_order_data(farmer)
    if !farmer.orders.empty?
      orders = farmer.orders.all.order(:id)
      order_data = orders.map do |order|
        [order, [order_total(order, farmer), items(order, farmer)]]
      end
      order_data.to_h
    else
      nil
    end
  end

  def self.remove_order_items(order, farmer)
    order_items = order.order_items
    order_items.each do |order_item|
      order_item.delete if farmer.items.include?(order_item.item)
    end
  end

  def self.remove_farmer_order(farmer, order_params)
    FarmerOrder.find_by(order_id: order_params[:id],
                        farmer_id: farmer.id).delete
  end
end
