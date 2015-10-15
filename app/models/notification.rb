class Notification
  TWILIO_PHONE_NUMBER = "9292266613"
  attr_reader :client

  def initialize
    @client = Twilio::REST::Client.new(ENV["twilio_sid"], ENV["twilio_token"])
  end

  def send_confirmation_message(phone_number, delivery_time)
    client.messages.create from: TWILIO_PHONE_NUMBER, to: phone_number,
      body: "Your order will be there in #{delivery_time} mins."
  end
end
