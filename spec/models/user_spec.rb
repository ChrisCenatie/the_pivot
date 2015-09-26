require 'rails_helper'

RSpec.describe User, type: :model do

  it "is valid with valid attributes" do
    user = User.new(email: "Justin@example.com", password: "password")
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
end
