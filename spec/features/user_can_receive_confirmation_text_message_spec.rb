require "rails_helper"

RSpec.feature "user can receive a confirmation text message" do

  scenario "after placing order" do
    skip "Skipping due to issues with twilio"
    create_order!

    expect(Order.last.notification).to eq("unsent")
  end
end
