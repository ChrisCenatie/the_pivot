require 'rails_helper'

RSpec.describe Address, type: :model do

  it "is valid with valid attributes" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          state: "CO",
                          zip_code: 80010)

    expect(address).to be_valid
  end

  it "is invalid without a user id" do
    address = Address.new(street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          state: "CO",
                          zip_code: 80010)

    expect(address).to be_invalid
  end

  it "is invalid without a street address" do
    address = Address.new(user_id: 1,
                          apt: "",
                          city: "Denver",
                          state: "CO",
                          zip_code: 80010)

    expect(address).to be_invalid
  end

  it "is invalid without a city" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          state: "CO",
                          zip_code: 80010)

    expect(address).to be_invalid
  end

  it "is invalid without a state" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          zip_code: 80010)

    expect(address).to be_invalid
  end

  it "is invalid without a zip code" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          state: "CO")

    expect(address).to be_invalid
  end

  it "only accepts a zip code 5 characters long" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          state: "CO",
                          zip_code: 8001)

    expect(address).to be_invalid
  end

  it "only accepts a zip code with integers" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          state: "CO",
                          zip_code: "ABCDE")

    expect(address).to be_invalid
  end

  it "only accepts a state 2 characters long" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          state: "C",
                          zip_code: 80010)

    expect(address).to be_invalid
  end

  it "only accepts a state with upper case characters" do
    address = Address.new(user_id: 1,
                          street_address: "1510 Blake Street",
                          apt: "",
                          city: "Denver",
                          state: "c$",
                          zip_code: 80010)

    expect(address).to be_invalid
  end
end
