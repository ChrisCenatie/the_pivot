require 'rails_helper'

RSpec.describe Farmer, type: :model do
  let(:farmer) { Farmer.new(name: 'McDonald') }

  it "is valid" do
    expect(farmer).to be_valid
    expect(farmer.slug).to eq("mcdonald")
  end

  it "is invalid without a name" do
    farmer.name = nil
    expect(farmer).to be_invalid
  end

  it 'name has to be unique' do
    farmer.save
    farmer2 = Farmer.new(name: "McDonald")

    expect(farmer2).to be_invalid
  end

  it 'slug has to be unique' do
    farmer.save
    farmer2 = Farmer.new(name: "Mcdonald")

    expect(farmer2).to be_invalid
  end

  it "only accepts a name between 6 and 30 characters" do
    farmer.name = "Bob"
    expect(farmer).to be_invalid

    farmer.name = "Bob McHenry St Thomas O'Dowell Jr Jr"
    expect(farmer).to be_invalid
  end
end
