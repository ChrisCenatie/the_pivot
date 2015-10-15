class AddFarmerIdToItem < ActiveRecord::Migration
  def change
    add_reference :items, :farmer, index: true, foreign_key: true
  end
end
