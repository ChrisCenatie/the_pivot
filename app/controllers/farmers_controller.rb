class FarmersController < ApplicationController
  def index
    @farmers = Farmer.where(active: true)
  end
end
