class Order < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  belongs_to :user

  has_many :order_items
  has_many :items, through: :order_items

  has_many :farmer_orders
  has_many :farmers, through: :farmer_orders

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

  def time
    created_at.strftime("%l:%M %P")
  end
end
