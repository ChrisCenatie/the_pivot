class User < ActiveRecord::Base
  has_secure_password
  validates :email, presence: true, uniqueness: true,
    length: { in: 6..30 },
    format: { with:
      /\A[a-zA-Z0-9._%+-]+@[a-zA-Z0-9._%+-]+.[a-zA-Z0-9._%+-]+\z/ }
  has_many :orders
  has_one :address

  enum role: [ :guest, :user, :vendor, :admin ]

  def name
    email.gsub(/@.*/, '')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def full_address
    "#{address.street_address} #{address.apt} #{address.city}, " +
      "#{address.state} #{address.zip_code}"
  end

  def update_all(user_information)
    user_information = user_information.merge( { user_id: self.id } )
    informer = UserInformationWrapper.new(user_information)
    user_params = informer.user_params
    address_params = informer.address_params

    if update(user_params) && update_or_create_address(address_params)
      return true
    else
      return false
    end
  end

  def update_or_create_address(params)
    address ? address.update(params) : Address.create(params)
  end
end
