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

  it "is invalid unless name is between 3 and 30 characters" do
    category.update(name: "As")
    expect(category).to be_invalid

    category.update(name: "asdfasdfasdfasdfasdfasdfasdfasdf")
    expect(category).to be_invalid
  end

  it 'has a default picture if not added' do
    category.save

    expect(category.image_url).to eql("http://questionarium.net/wp-content/uploads/sites/4/2014/01/Foods-That-Are-High-In-Cholesterol.jpg")
  end
end
