class Item < ActiveRecord::Base
  belongs_to :category
  validates :name, :description, :price, :category_id, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: { greater_than: 0 }

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" } #No default image
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
