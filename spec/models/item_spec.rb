require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:item) { Item.new(name: 'Soda',
                        description: 'Sugary',
                        price: 350,
                        category_id: 1,
                        farmer_id: farmer.id) }

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

  it 'is invalid without a category_id' do
    item.category_id = nil
    expect(item).to be_invalid
  end

  it 'must have a price greater than 0' do
    item.price = -1
    expect(item).to be_invalid
  end

  it 'name has to be unique' do
    item.save
    item2 = Item.new(name: 'Soda',
                    description: 'sweet',
                    price: 350,
                    category_id: 1)

    expect(item2).to be_invalid
  end

  it 'has a default picture if not added' do
    item.save

    expect(item.image_url).to eql("http://questionarium.net/wp-content/uploads/sites/4/2014/01/Foods-That-Are-High-In-Cholesterol.jpg")
  end

  it 'is invalid without a farmer' do
    item2 = Item.new(name: 'Soda',
                     description: 'Sugary',
                     price: 350,
                     category_id: 1)

    expect(item2).to be_invalid
  end

end
