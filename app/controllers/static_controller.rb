class StaticController < ApplicationController

  def index
    @disable_nav = true
    render layout: "splash"
  end

  def show
    vendor_data = [ {name: "Willowcroft Farm", image_url: "http://www.oldhousedreams.com/wp-content/uploads/2010/07/3791hunter1.jpg"},
      { name: "Zenger Farm", image_url: "https://lh4.googleusercontent.com/uoXwnXLYZqDFbqVdGEjvSEN2IrbPGYrdS_gD0wgVMwNSf6kXcu_evZKJQaOk0sNQCjrCwrvek1057vtkLn2bhyuNeXUnJxz4tKjumcMH-b3lfJA9wgQ"},
      {name: "Black River Farm", image_url: "http://luxport.s3.amazonaws.com/53174/7285+East+Saanich+Road+Central+Saanich+BC+Canada+389546_1-EXT.JPG"} ]

    @vendors = vendor_data.map { |vendor| Vendor.new(vendor) }

    render :vendors_index
  end
end
