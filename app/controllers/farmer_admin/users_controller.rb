class FarmerAdmin::UsersController < FarmerAdminController
  def show
    @farmer_admins = User.where(farmer: current_user.farmer.id)
    farmer = current_user.farmer
    @orders_data = FarmerAdminOrders.farmer_order_data(farmer)
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
      create_farmer_admin(user)
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

    def create_farmer_admin(user)
      user.role = 2
      user.farmer_id = current_user.farmer.id
      user.save
    end
end
