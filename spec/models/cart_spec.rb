require "rails_helper"

RSpec.describe Cart, type: :model do

  let(:farmer) {Farmer.create(name: "McDonald")}
  let(:item1) {Item.create(name: 'Seeds',
                           description: 'Yummy',
                           price: 100,
                           category_id: 1,
                           farmer_id: farmer.id)}
  let(:item2) {Item.create(name: 'Almonds',
                           description: 'Dericious',
                           price: 200,
                           category_id: 1,
                           farmer_id: farmer.id)}
  let(:item3) {Item.create(name: 'Cashews',
                           description: 'Tasty',
                           price: 300,
                           category_id: 1,
                           farmer_id: farmer.id)}

  it "is empty by default" do
    cart = Cart.new
    expect(cart.data).to eq({})
  end

  describe "#items" do

    it "returns all items and quantities" do
      cart = Cart.new
      cart.add_item(item1.id)
      cart.add_item(item2.id)
      cart.add_item(item3.id)
      expect(cart.items.count).to eq(3)
      expect(cart.items.last.name).to eq('Cashews')
      expect(cart.items.last.description).to eq('Tasty')
    end
  end

  describe "#add_item" do
    it "can add an item" do
    	cart = Cart.new
      cart.add_item(item1.id)
      expect(cart.data).to eq("#{item1.id}" => 1)
    end

    it "can add multiple items" do
      cart = Cart.new
      3.times {cart.add_item(item1.id)}
      expect(cart.data).to eq("#{item1.id}" => 3)
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
