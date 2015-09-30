class StaticController < ApplicationController

  def index
   @disable_nav = true
  end
  def show
    vendor_data = [ { name: "McDonalds", image_url: "http://www.walnet.ca/sites/default/files/styles/portfolio-thumbnail/public/portfolio/mcdonalds.jpg?itok=nC_5t4cQ"},
      {name: "Hapa Sushi", image_url: "http://denver.cities2night.com/public/place_images/place_4156.jpg"},
      {name: "TGI Friday's", image_url: "http://www.microsoftproductreviews.com/wp-content/uploads/2015/01/Video-Production-Birmingham-London-TGI-Fridays-Promo-Video-13.png"} ]

    @vendors = vendor_data.map { |v| Vendor.new(v) }

    render :vendors_index
  end
end

