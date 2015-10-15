class StaticController < ApplicationController

  def index
    @disable_nav = true
    render layout: "splash"
  end
end
