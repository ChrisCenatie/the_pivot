require "rails_helper"

RSpec.describe Cart, type: :model do

  let(:item) {Item.create(name: 'Seeds', description: 'Yummy', price: 100)}

  it "is empty by default" do
    cart = Cart.new
    expect(cart.data).to eq({})
  end

  describe "#items" do

    let(:item1) {Item.create(name: 'Seeds', description: 'Yummy', price: 100)}
    let(:item2) {Item.create(name: 'Almonds', description: 'Dericious', price: 200)}
    let(:item3) {Item.create(name: 'Cashews', description: 'Tasty', price: 300)}

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
      cart.add_item(item.id)
      expect(cart.data).to eq("#{item.id}" => 1)
    end

    it "can add multiple items" do
      cart = Cart.new
      3.times {cart.add_item(item.id)}
      expect(cart.data).to eq("#{item.id}" => 3)
    end
  end

end