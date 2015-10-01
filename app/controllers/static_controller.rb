class StaticController < ApplicationController

  def index
    @disable_nav = true
  end

  def show
    vendor_data = [ { name: "Fontana", image_url: "http://static1.squarespace.com/static/5292c961e4b09bd017955724/529587bde4b01d85129152d0/529587c3e4b05d949cd64b17/1402483795792/20-Fontana_Logo_Hall_and_Lien.jpg"},
      {name: "Sushi Supply", image_url: "http://orig04.deviantart.net/9b5f/f/2010/220/d/9/sushi_supply_by_gustavitos.png"},
      {name: "El Mexican Restaurant", image_url: "http://www.blankisthenewblack.com/img/ourwork/3-1_EL-Logo_K1b.jpg"} ]

    @vendors = vendor_data.map { |vendor| Vendor.new(vendor) }

    render :vendors_index
  end
end
