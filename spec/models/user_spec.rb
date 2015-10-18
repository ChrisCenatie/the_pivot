require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with valid attributes" do
    user = User.new(email: "Justin@example.com", password: "password",
      first_name: "Justin", last_name: "Beiber", phone_number: "555-555-5555")
    expect(user).to be_valid
  end

  it "is invalid without a password" do
    user = User.new(email: "Justin@example.com")
    expect(user).to be_invalid
  end

  it "is invalid without an email" do
    user = User.new(password: "password")
    expect(user).to be_invalid
  end

  it "is invalid if email not unique" do
    User.create(email: "Justin@example.com", password: "password")
    user = User.new(email: "Justin@example.com", password: "password")
    expect(user).to be_invalid
  end

  it "cannot create a user non-email characters" do
    user = User.new(email: "Justin25!@example.com", password: "password")
    expect(user).to be_invalid
  end

  it "only accepts an email between 6 and 30 characters" do
    user = User.new(email: "J@j.j", password: "password")
    expect(user).to be_invalid

    user = User.new(email: "johnjacobjingleheimerschmidt@example.com",
      password: "password")
    expect(user).to be_invalid
  end

  it "has a role of user by default" do
    user = User.create(email: "Justin@example.com", password: "password")

    expect(user.role).to eq("user")
  end

  describe "#full_name" do
    it "calculates its full name from its first and last name" do
      user = User.create(email: "Justin@example.com", password: "password",
        first_name: "Justin", last_name: "Holzmann")
      expect(user.full_name).to eq("Justin Holzmann")
    end
  end

  describe "#full_address" do
    it "calculates its full address from its components" do
      user = User.create(email: "Justin@example.com", password: "password",
      first_name: "Justin", last_name: "Beiber", phone_number: "555-555-5555")
      Address.create(user_id: user.id, street_address: "1510 Blake street",
        apt: "basement", city: "Denver", state: "CO", zip_code: "80110")
      expect(user.full_address).to eq("1510 Blake street basement Denver, CO 80110")
    end
  end
end
