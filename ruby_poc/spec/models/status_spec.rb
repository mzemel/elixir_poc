require 'spec_helper'

RSpec.describe Status do
  context ".start" do
    it "can receive an argument" do
      expect{Status.start("foo")}.to_not raise_error
    end

    it "can talk to redis" do
      expect_any_instance_of(Redis).to receive(:hset)
      Status.start(1)
    end
  end

  context ".complete" do
    it "can talk to redis" do
      expect_any_instance_of(Redis).to receive(:hset)
      Status.complete(1)
    end
  end

  context ".status" do
    it "can receive a 'start' status" do
      Status.start(1)
      expect(Status.status(1)).to eq("start")
    end

    it "can receive a 'complete' status" do
      Status.complete(1)
      expect(Status.status(1)).to eq("complete")
    end

    it "can transition from start to complete" do
      Status.start(1)
      Status.complete(1)
      expect(Status.status(1)).to eq("complete")
    end

    it "can receive a 'not found' status" do
      expect(Status.status(2)).to eq("not found")
    end
  end

  context ".clear" do
    it "clears redis" do
      Status.start(1)
      Status.clear
      expect(Status.status(1)).to eq("not found")
    end
  end
end