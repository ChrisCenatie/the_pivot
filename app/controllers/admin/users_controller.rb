class Admin::UsersController < AdminController
  def show
    @orders = Order.all
  end
end
