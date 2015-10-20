class Farmer < ActiveRecord::Base
  has_many :items
  has_many :users
  
  validates :slug, presence: true, uniqueness: true,
            length: { in: 6..30 }

  before_validation :generate_slug

  def generate_slug
    self.slug = name.parameterize if name
  end
end
