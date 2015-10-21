class CreateFarmerOrders < ActiveRecord::Migration
  def change
    create_table :farmer_orders do |t|
      t.belongs_to :farmer, index: true
      t.belongs_to :order, index: true
    end
  end
end
