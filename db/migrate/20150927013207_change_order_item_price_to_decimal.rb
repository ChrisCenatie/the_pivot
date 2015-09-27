class ChangeOrderItemPriceToDecimal < ActiveRecord::Migration
  def change
    change_column :order_items, :price, :decimal
  end
end
