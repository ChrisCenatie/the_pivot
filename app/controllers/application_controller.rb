class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    User.find(session[:user_id]) rescue nil
  end

  helper_method :cart, :current_user
end
