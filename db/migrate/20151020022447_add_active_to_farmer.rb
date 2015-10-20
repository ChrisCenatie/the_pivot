class AddActiveToFarmer < ActiveRecord::Migration
  def change
    add_column :farmers, :active, :boolean, default: false
  end
end
