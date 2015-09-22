class Item < ActiveRecord::Base
  validates :name, :description, :price, presence: true

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" } #No default image
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
end
