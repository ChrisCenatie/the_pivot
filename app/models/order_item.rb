class OrderItem < ActiveRecord::Base
  validates :order_id, :item_id, :quantity, :price, presence: true

  belongs_to :item
  belongs_to :order
end
