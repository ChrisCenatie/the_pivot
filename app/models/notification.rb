class Notification
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new(ENV["twilio_sid"], ENV["twilio_token"])
  end

  def send_confimation_message(phone_number, delivery_time)
    client.messages.create from: "7203706615", to: phone_number, body: "Your order
    will be there in #{delivery_time} mins."
  end
end
