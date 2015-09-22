class Category < ActiveRecord::Base
  has_many :items
  validates :name, presence: true,
    length: { in: 3..30 }
end
