require 'spec_helper'

RSpec.describe StatusController, type: :controller do
  context "GET /:id" do
    it "succeeds" do
      get :show, id: 1
      expect(response).to be_success
    end

    it "responds with a status" do
      get :show, id: 1
      status = JSON.parse(response.body)["status"]
      expect(status).to be_a String
    end

    it "returns 'start' for a status of 'start'" do
      Status.start(1)
      get :show, id: 1
      status = JSON.parse(response.body)["status"]
      expect(status).to eq("start")
    end

    it "returns 'complete' for a status of 'complete'" do
      Status.complete(1)
      get :show, id: 1
      status = JSON.parse(response.body)["status"]
      expect(status).to eq("complete")
    end
  end
end