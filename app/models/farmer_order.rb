class FarmerOrder < ActiveRecord::Base
  validates :order_id, :farmer_id, presence: true

  belongs_to :farmer
  belongs_to :order
end
