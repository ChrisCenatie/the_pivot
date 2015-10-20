class AddFarmerIdToUser < ActiveRecord::Migration
  def change
    add_reference :users, :farmer, foreign_key: true
  end
end
