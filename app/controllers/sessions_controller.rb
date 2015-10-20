class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      redirect_to role_route(user)
    else
      flash.now[:errors] = "Invalid credentials, please try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out"
    session[:cart] = nil
    redirect_to root_path
  end

    private

    def role_route(user)
      if user.admin?
        admin_dashboard_path
      elsif user.farmer_admin?
        farmer_admin_dashboard_path
      else
        redirect_path
      end
    end

    def redirect_path
      if previous_path == cart_path || previous_path == "/categories/*/items"
        cart_path
      else
        user_path(current_user)
      end
    end
end
