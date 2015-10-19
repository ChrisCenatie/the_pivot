class AddressesController < ApplicationController

  def new
  end

  def create
    address = Address.new(address_params, user_id: current_user.id)
    address.user_id = current_user.id
    if address.save
      flash[:notice] = "Address successfully added"
      redirect_to cart_path
    else
      flash.now[:errors] = address.errors.full_messages
      render :new
    end
  end

  private

    def address_params
      params.require(:address).permit(:street_address, :apt, :city, :state,
        :zip_code)
    end
end
