class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:sessions][:email])
    if user && user.authenticate(params[:sessions][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:errors] = "YOU ARE INVALID"
      render :new
    end
  end
end
