require "rails_helper"

RSpec.feature "admin can change the status of orders" do
  before(:each) do
    create_user!
    create_item!
    @order1 = Order.create(user_id: user.id, status: 0)
    @order2 = Order.create(user_id: user.id, status: 1)
    OrderItem.create(order_id: @order1.id, quantity: 3, price: 4, item_id: item.id)
    OrderItem.create(order_id: @order2.id, quantity: 15, price: 4, item_id: item.id)
  end

  scenario "when they go to the dashboard" do
    login_admin!

    expect(page).to have_link("Ordered: 1")
    expect(page).to have_link("Paid: 1")

    within(:css, "div#order_#{@order1.id}") do
      click_on("Mark as paid")
    end

    expect(page).to_not have_link("Ordered: 1")
    expect(page).to have_link("Paid: 2")

    within(:css, "div#order_#{@order2.id}") do
      click_on("Mark as completed")
    end

    expect(page).to have_link("Paid: 1")
    expect(page).to have_link("Completed: 1")

    within(:css, "div#order_#{@order1.id}") do
      click_on("Cancel")
    end

    expect(page).to_not have_link("Paid: 1")
    expect(page).to have_link("Cancelled: 1")

  end
end
