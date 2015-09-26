class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true,
    length: { in: 6..30 },
    format: { with:
      /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9._%+-]+.[a-zA-Z0-9._%+-]+\z/ }
  has_many :orders

  enum role: [ :guest, :user, :vendor, :admin ]

  def name
    email.gsub(/@.*/, '')
  end
end
