defmodule ImageUploadWorkerTest do
  use ExUnit.Case

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PhoenixImageSvc.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(PhoenixImageSvc.Repo, {:shared, self()})
    
    ImageUploadStatus.start_link(%{})
    ImageUploadWorker.start_link(%{id: nil, image: nil})
    :ok
  end

  test "returns no internal data" do
    assert ImageUploadWorker.image == nil
  end

  test "returns internal data" do
    ImageUploadWorker.process(%{id: "some_id", image: "010101010101"})
    assert ImageUploadWorker.image == "010101010101"
  end

  # Parallelism is awesome but leads to race conditions
  # Unclear if Worker will have sent message to Status yet
  # So allow for either state -- as long as it's in Status
  test "sets status in ImageUploadStatus" do
    {:ok, id} = ImageUploadWorker.process(%{id: "some_id", image: "010101010101"})
    {:ok, status} = ImageUploadStatus.status(id)
    assert Enum.member?(["start", "complete"], status) == true
  end
end