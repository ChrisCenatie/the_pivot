class AddImageUrlToFarmers < ActiveRecord::Migration
  def change
    add_column :farmers, :image_url, :string
  end
end
