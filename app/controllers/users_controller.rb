class UsersController < ApplicationController
  before_action :verify_user, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path(id: @user.id)
    elsif User.find_by(params[:email])
      flash[:errors] = "That email address is taken"
      redirect_to new_user_path
    else
      flash[:errors] = "Invalid login attempt"
      redirect_to new_user_path
    end
  end

  def show
    if session[:user_id].to_i == params[:id].to_i
      @user = User.find(params[:id])
      @orders = @user.orders
    else
      flash.now[:errors] =
        "You are not authorized to view this page"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

  def verify_user
    if current_user && current_user.id == params[:id].to_i
      true
    else
      render file: "#{Rails.root}/public/401.html", layout: false, status: 401
    end
  end
end
