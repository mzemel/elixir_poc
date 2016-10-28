require 'spec_helper'

RSpec.describe Upload do
  context ".create" do
    let(:valid_attrs) { { name: "something" } }

    it "creates a record" do
      allow(UploadWorker).to receive(:perform_async)
      expect do
        Upload.create(valid_attrs)
      end.to change{Upload.count}.by(1)
    end

    it "creates a 'start' status" do
      allow(UploadWorker).to receive(:perform_async)
      expect(Status).to receive(:start)
      Upload.create(valid_attrs)
    end

    it "returns a record with an id" do
      allow(UploadWorker).to receive(:perform_async)
      upload = Upload.create(valid_attrs)
      expect(upload.id).to_not be_nil
    end

    it "creates an async job" do
      expect(UploadWorker).to receive(:perform_async).with(kind_of(Integer))
      Upload.create(valid_attrs)
    end
  end
end