require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) do
    Item.new(name: 'Soda', description: 'Sugary', price: 350)
  end

  it 'is valid' do
    expect(item).to be_valid
  end

  it 'is invalid without a name' do
    item.name=nil
    expect(item).to be_invalid
  end

  it 'is invalid without a description' do
    item.description=nil
    expect(item).to be_invalid
  end

  it 'is invalid without a price' do
    item.price=nil
    expect(item).to be_invalid
  end
end
