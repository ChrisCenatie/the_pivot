class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      if user.admin?
        redirect_to(admin_dashboard_path)
      else
        redirect_to(redirect_path)
      end
    else
      flash.now[:errors] = "Invalid credentials, please try again"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You are now logged out"
    redirect_to root_path
  end

  private

  def redirect_path
    if previous_path == cart_path || previous_path == items_path
      cart_path
    else
      user_path(current_user)
    end
  end
end
