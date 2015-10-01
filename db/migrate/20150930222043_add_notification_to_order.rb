class AddNotificationToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :notification, :integer, default: 0
  end
end
