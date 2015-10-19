class AddressesController < ApplicationController

  def new
  end

  def create
    address = Address.new(address_params, user_id: current_user.id)
    address.user_id = current_user.id
    if address.save
      flash[:notice] = "Address successfully added"
      redirect_to previous_path
    else
      flash.now[:errors] = address.errors.full_messages
      render :new
    end
  end

  def update
    if current_user.address.update(update_address) && (!update_address.empty?)
      flash[:notice] = "Address successfully updated"
      redirect_to edit_user_path(current_user.id)
    else
      flash[:errors] = "Invalid Address Attributes"
      redirect_to edit_user_path(current_user.id)
    end
  end

  private

    def address_params
      params.require(:address).permit(:street_address, :apt, :city, :state,
        :zip_code)
    end

    def update_address
      update_params = {}
      address_params.each do |key, value|
        update_params[key] = value if value != ""
      end
      update_params
    end
end
