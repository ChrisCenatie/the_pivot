class UsersController < ApplicationController
  before_action :verify_user, only: [:show, :edit]

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
    @user = User.find(params[:id])
    @orders = @user.orders
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_all(user_and_address_params)
      redirect_to previous_path
    else
      flash.now[:errors] = "Invalid input params"
      render :edit
    end
  end

  private

  def user_and_address_params
    params.require(:user_and_address).permit(:email, :password, :first_name,
      :last_name, :street_address, :apt, :city, :state, :zip_code)
  end

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name)
  end

  def verify_user
    if current_user && current_user.id == params[:id].to_i
      true
    else
      render file: "#{Rails.root}/public/401.html", layout: false, status: 401
    end
  end
end
