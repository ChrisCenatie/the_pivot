class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :user
  enum status: [ :ordered, :paid, :cancelled, :completed ]
  enum notification: [ :unsent, :sent ]

  validates :user_id, presence: true
  has_many :order_items

  def total_price
    price = order_items.reduce(0) do |sum, order_item|
      sum += order_item.quantity * order_item.price
    end
    number_to_currency(price)
  end

  def date
    created_at.strftime("%b %e %Y")
  end

  def ordered
    Order.where(status: "ordered")
  end

  def paid
    Order.where(status: "paid")
  end

  def cancelled
    Order.where(status: "cancelled")
  end

  def completed
    Order.where(status: "completed")
  end
end
