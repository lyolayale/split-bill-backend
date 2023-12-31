require "rails_helper"

RSpec.describe Friend, type: :model do
  it "should validate friend's attributes, no attributes should be empty" do
    friend = Friend.create
    expect(friend.errors[:name]).to_not be_empty
    expect(friend.errors[:event]).to_not be_empty
    expect(friend.errors[:balance]).to_not be_empty
  end
  it "friend's attribute balance should be a number: testing integer" do
    friend = Friend.create(name: "The Dude", event: "Base jumping", balance: 100)
    expect(friend.balance).to be_a_kind_of(Integer)
    expect(friend.balance).not_to be_an_instance_of(String)
  end
  it "friend's attribute balance should be a number: testing float" do
    friend = Friend.create(name: "The Dude", event: "Base jumping", balance: 100.00)
    expect(friend.balance).to be_a_kind_of(Integer)
    expect(friend.balance).not_to be_an_instance_of(String)
  end
  it "friend's attribute balance should be a number: testing string" do
    friend = Friend.create(name: "The Dude", event: "Base jumping", balance: "100")
    expect(friend.balance).to be_a_kind_of(Integer)
    expect(friend.balance).not_to be_an_instance_of(String)
  end
  it "friend's attribute: name, should be 2 or more characters" do
    friend = Friend.create(name: "U", event: "Base Jumping", balance: 100)
    expect(friend.errors[:name]).to include "is too short (minimum is 2 characters)"
  end
  it "friend's attribute: event, should be 5 or more characters" do
    friend = Friend.create(name: "The Dude", event: "nope", balance: 100)
    expect(friend.errors[:event]).to include "is too short (minimum is 5 characters)"
  end
end
