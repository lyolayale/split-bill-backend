require "rails_helper"

RSpec.describe "Friends", type: :request do
  describe "GET /index" do
    it "get a list of friends" do
      Friend.create name: "The Dude", event: "Hang gliding", balance: -100

      get "/friends"

      friend = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(friend.length).to eq 1
    end
  end
  describe "POST /create" do
    it "creates a friend" do
      friend_params = { friend: { name: "The Dude", event: "Hang gliding", balance: -100 } }

      post "/friends", params: friend_params
      expect(response).to have_http_status(200)

      friend = Friend.first
      expect(friend.name).to eq "The Dude"
      expect(friend.event).to eq "Hang gliding"
      expect(friend.balance).to eq -100
    end
    it "does not create a friend without a name attribute" do
      friend_params = { friend: { event: "Hang gliding", balance: -100 } }

      post "/friends", params: friend_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json["name"]).to include "can't be blank"
    end
    it "does not create a friend without a event attribute" do
      friend_params = { friend: { name: "The Dude", balance: -100 } }

      post "/friends", params: friend_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json["event"]).to include "can't be blank"
    end
    it "does not create a friend without a balance attribute" do
      friend_params = { friend: { name: "The Dude", event: "Hang gliding" } }

      post "/friends", params: friend_params
      expect(response.status).to eq 422
      json = JSON.parse(response.body)
      expect(json["balance"]).to include "can't be blank"
    end
  end
  describe("PATCH /update") do
    let!(:friend) {
      Friend.create(name: "The Dude", event: "Hang gliding", balance: -100)
    }
    context("with valid parameters") do
      let(:name_params) { { friend: { name: "Billie Jean" } } }
      let(:event_params) { { friend: { event: "Cliff jumping" } } }
      let(:balance_params) { { friend: { balance: 500 } } }
      it "changes a friend's name" do
        patch "/friends/#{friend.id}", params: name_params
        friend.reload
        expect(response).to have_http_status(200)
        expect(friend.name).to eq "Billie Jean"
      end
      it "changes a friend's event" do
        patch "/friends/#{friend.id}", params: event_params
        friend.reload
        expect(response.status).to eq 200
        expect(friend.event).to eq "Cliff jumping"
      end
      it "changes a friend's balance" do
        patch "/friends/#{friend.id}", params: balance_params
        friend.reload
        expect(response.status).to eq 200
        expect(friend.balance).to eq 500
      end
      it "does not update without valid parameters" do
        friend_params = { friend: { name: "The Dude", event: "Hang gliding", balance: -100 } }

        post "/friends", params: friend_params
        friend = Friend.first
        updated_params = { friend: { name: "", event: "", balance: nil } }
        patch "/friends/#{friend.id}", params: updated_params
        expect(response.status).to eq 422
      end
    end
  end
  describe "DELETE /destroy" do
    it "removes a friend" do
      friend_params = { friend: { name: "The Dude", event: "Hang gliding", balance: -100 } }
      post "/friends", params: friend_params
      friend = Friend.first

      delete "/friends/#{friend.id}"

      expect(response.status).to eq 200
      friends = Friend.all
      expect(friends).to be_empty
    end
  end
end
