require 'spec_helper'

RSpec.describe UploadsController, type: :controller do
  context "POST create" do
    let(:valid_attrs) { { name: "something" } }

    it "posts valid attributes if json" do
      allow(UploadWorker).to receive(:perform_async)
      post :create, valid_attrs.merge(format: :json)
      expect(response).to be_success
    end

    it "does not respond to html" do
      allow(UploadWorker).to receive(:perform_async)
      expect do
        post :create, valid_attrs
      end.to raise_error(ActionController::UnknownFormat)
    end

    it "calls Upload#create" do
      allow(UploadWorker).to receive(:perform_async)
      expect(Upload).to receive(:create).and_call_original
      post :create, valid_attrs.merge(format: :json)
    end

    it "returns the id" do
      allow(UploadWorker).to receive(:perform_async)
      post :create, valid_attrs.merge(format: :json)
      id = JSON.parse(response.body)["id"]
      expect(id).to be_a Fixnum
    end

    it "sends a message to Status" do
      allow(UploadWorker).to receive(:perform_async)
      expect(Status).to receive(:start).with(instance_of(Fixnum))
      post :create, valid_attrs.merge(format: :json)
    end
  end
end