require "rails_helper"

RSpec.describe Cart, type: :model do

  it "is empty by default" do
    cart = Cart.new
    expect(cart.data).to eq({})
  end

  describe "#items" do

    it "returns all items and quantities" do
      cart = Cart.new
      cart.add_item(item.id)
      cart.add_item(item1.id)
      cart.add_item(item2.id)
      expect(cart.items.count).to eq(3)
      expect(cart.items.last.name).to eq('Burger')
      expect(cart.items.last.description).to eq('beef')
    end
  end

  describe "#add_item" do
    it "can add an item" do
    	cart = Cart.new
      cart.add_item(item.id)
      expect(cart.data).to eq("#{item.id}" => 1)
    end

    it "can add multiple items" do
      cart = Cart.new
      3.times {cart.add_item(item.id)}
      expect(cart.data).to eq("#{item.id}" => 3)
    end
  end

  describe "#remove_item" do
    it "can remove an item" do
      cart = Cart.new
      cart.add_item(item1.id)
      cart.remove_item(item1.id)

      expect(cart.data).to eq({})
    end

    it "can remove multiple items" do
      cart = Cart.new
      cart.add_item(item1.id)
      cart.add_item(item1.id)
      cart.add_item(item2.id)

      expect(cart.data).to eq("#{item2.id}" => 1, "#{item1.id}" => 2)

      cart.remove_item(item1.id)
      cart.remove_item(item2.id)

      expect(cart.data).to eq("#{item1.id}" => 1)
    end
  end

end
