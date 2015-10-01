class NotificationsController < ApplicationController

  skip_before_action :verify_authentication_token

  def notify
    render plain: message.status
  end
end
