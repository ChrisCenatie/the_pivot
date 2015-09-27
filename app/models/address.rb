class Address < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :street_address, :city, presence: true
  validates :zip_code, presence: true,
    length: { is: 5 },
    format: { with: /\A[0-9]+\z/ }
  validates :state, presence: true,
    length: { is: 2 },
    format: { with: /\A[A-Z]+\z/ }
end
