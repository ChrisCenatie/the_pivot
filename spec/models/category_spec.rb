require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category) do
    Category.new(name: "Meals")
  end

  it "has items" do
    expect(category).to respond_to(:items)
  end

  it "is invalid without a name" do
    category = Category.new
    expect(category).to be_invalid
  end

  it "is valid with a name" do
    expect(category).to be_valid
  end

end
