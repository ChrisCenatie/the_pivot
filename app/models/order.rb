class Order < ActiveRecord::Base
  belongs_to :user
  enum status: [ :ordered, :paid, :cancelled, :completed ]

  validates :user_id, presence: true
  has_many :order_items

  def total_price
    order_items.reduce(0) do |sum, order_item|
      sum += order_item.quantity * order_item.price
    end
  end

end
