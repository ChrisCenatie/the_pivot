class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_action :set_previous_path

  private

  def cart
    @cart ||= Cart.new(session[:cart])
  end

  def current_user
    User.find(session[:user_id]) rescue nil
  end

  def previous_path
    session[:previous_path]
  end

  def set_previous_path
    session[:previous_path] =
      request.env["HTTP_REFERER"].gsub(/\w*\:\/\/[^\/]+/, '') rescue nil
  end

  def not_logged_in?(message)
    if !current_user
      flash[:errors] = message
      redirect_to login_path and return
    end
    return true
  end

  def current_farm
    Farmer.find_by(slug: params[:farmer])
  end

  helper_method :cart, :current_user, :previous_path, :current_farm
end
