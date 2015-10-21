require "rails_helper"

RSpec.feature "user can receive a confirmation text message" do

  scenario "after placing order" do
    # skip "Skipping due to issues with twilio"
    create_order!

    expect(current_path).to eq("/orders/#{Order.last.id}")
    expect(page).to have_content("Total: $9.00")
    expect(page).to have_content("Order #{Order.last.id}")
    expect(Order.last.notification).to eq("sent")
  end
end
