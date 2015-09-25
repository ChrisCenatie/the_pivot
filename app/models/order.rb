class Order < ActiveRecord::Base
  belongs_to :user
  enum status: [ :ordered, :paid, :cancelled, :completed ]

  validates :user_id, presence: true
  has_many :order_items
end
