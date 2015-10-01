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

  def update_all(u_a_params)
    user_params = {email: u_a_params[:email],
      password: u_a_params[:password],
      phone_number: u_a_params[:phone_number],
      first_name: u_a_params[:first_name],
      last_name: u_a_params[:last_name] }.select {|_,v| v }.to_h

    address_params = {street_address: u_a_params[:street_address],
      apt: u_a_params[:apt],
      city: u_a_params[:city],
      state: u_a_params[:state],
      zip_code: u_a_params[:zip_code],
      user_id: self.id }.select {|_,v| v }.to_h

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
