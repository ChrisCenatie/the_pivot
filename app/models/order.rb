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
end
