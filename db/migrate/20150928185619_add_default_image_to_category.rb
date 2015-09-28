class AddDefaultImageToCategory < ActiveRecord::Migration
  def change
    change_column :categories, :image_url, :string, default: "http://questionarium.net/wp-content/uploads/sites/4/2014/01/Foods-That-Are-High-In-Cholesterol.jpg"
  end
end
