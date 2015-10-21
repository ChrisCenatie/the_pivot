class OrderCreator
  attr_reader :cart_data, :user

  def initialize(cart_data, user)
    @cart_data = cart_data
    @user      = user
  end

  def order
    @order ||= user.orders.create
  end

  def total_price
    cart_items = cart_data.reduce(0) do |sum, id_quantity|
      sum += Item.find(id_quantity[0]).price * id_quantity[1]
    end
  end

end
