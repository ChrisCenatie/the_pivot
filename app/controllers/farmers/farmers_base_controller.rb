class Farmers::FarmersBaseController < ApplicationController
  helper_method :current_farmer

  def current_farmer
    @current_farmer ||= Farmer.find_by(slug: params[:farmer])
  end
end
