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

  def current_admin?
    current_user && current_user.admin?
  end

  def previous_path
    session[:previous_path]
  end

  def set_previous_path
    unless request_referrer == ("/addresses/new" || "/addresses")
    session[:previous_path] =
      request_referrer
    end
  end

  def request_referrer
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

  def admin_authorized?
    current_user && current_user.admin?
  end

  def farmer_admin_authorized?
    current_user && current_user.farmer_admin?
  end

  def current_farmers_farm?
    farmer_admin_authorized? && current_user.farmer == current_farm
  end

  def current_farmers_item?(item)
    farmer_admin_authorized? && (current_user.farmer.id == item.farmer.id)
  end

  helper_method :cart,
                :current_user,
                :current_admin?,
                :previous_path,
                :current_farm,
                :admin_authorized?,
                :farmer_admin_authorized?,
                :current_farmers_farm?,
                :current_farmers_item?
end
