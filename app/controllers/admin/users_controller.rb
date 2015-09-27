class Admin::UsersController < AdminController
  def show
    if session[:filter]
      @orders = Order.where(status: session[:filter])
    else
      @orders = Order.all
    end
  end

  def update
    session[:filter] = params[:filter]
    redirect_to admin_dashboard_path
  end
end
