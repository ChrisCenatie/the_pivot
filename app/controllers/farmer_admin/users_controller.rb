class FarmerAdmin::UsersController < FarmerAdminController
  def show
    @farmer_admins = User.where(farmer: current_user.farmer.id)
    farmer = current_user.farmer
    if !farmer.orders.empty?
      orders = farmer.orders.all.order(:id)
      order_data = orders.map do |order|
        [order, [order_total(order), items(order)]]
      end
      @orders_data = order_data.to_h
    else
      @orders_data = nil
    end
  end

  def update
    if user = User.find_by(email: params[:user][:email])
      user.update(role: 2,
                  farmer_id: current_user.farmer.id) unless (user.admin? || user.farmer_admin?)
      flash[:notice] = "New Farmer Admin, #{user.name} Added for #{current_user.farmer.name}!"
      redirect_to farmer_admin_dashboard_path
    else
      flash[:errors] = "Couldn't find a user with that email"
      redirect_to new_farmer_admin_user_path
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.valid?
      user.role = 2
      user.farmer_id = current_user.farmer.id
      user.save
      flash[:notice] = "New Farmer Admin, #{user.name} Added for #{current_user.farmer.name}!"
      redirect_to farmer_admin_dashboard_path
    else
      flash[:errors] = user.errors.full_messages
      redirect_to new_farmer_admin_user_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :phone_number, :first_name,
      :last_name)
  end

  def order_total(order)
    order_items = order.order_items
    price_quantities = order_items.map do |order_item|
      if current_user.farmer.items.include?(Item.find(order_item.item_id))
        order_item.quantity * order_item.price
      else
        0
      end
    end
    price_quantities.reduce(:+)
  end

  def items(order)
    order_items = order.order_items
    items = []
    order_items.each do |order_item|
      item = Item.find(order_item.item_id)
      items << item.name if current_user.farmer.items.include?(item)
    end
    items
  end
end
