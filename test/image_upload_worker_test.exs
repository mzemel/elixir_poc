defmodule ImageUploadWorkerTest do
  use ExUnit.Case

  setup do
    # Explicitly get a connection before each test
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(PhoenixImageSvc.Repo)
    # Setting the shared mode must be done only after checkout
    Ecto.Adapters.SQL.Sandbox.mode(PhoenixImageSvc.Repo, {:shared, self()})
    
    ImageUploadStatus.start_link(%{})
    {:ok, id} = ImageUploadWorker.start_link("010101010101")
    [id: id]
  end

  test "returns internal data" do
    assert ImageUploadWorker.get_data == "010101010101"
  end

  # Parallelism is awesome but leads to race conditions
  # Unclear if Worker will have sent message to Status yet
  # So allow for either state -- as long as it's in Status
  test "sets status in ImageUploadStatus", context do
    {:ok, status} = ImageUploadStatus.status(context[:id])
    assert Enum.member?(["start", "complete"], status) == true
  end
end