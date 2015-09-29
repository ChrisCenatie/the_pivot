class Vendor
  attr_reader :name, :image_url


  def initialize(params)
    @name = params[:name]
    @image_url = params[:image_url]
  end
end
