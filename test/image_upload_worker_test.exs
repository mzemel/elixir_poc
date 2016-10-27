defmodule ImageUploadWorkerTest do
  use ExUnit.Case

  # http://elixir-lang.org/docs/stable/ex_unit/ExUnit.Callbacks.html
  setup_all do
    ImageUploadStatus.start_link(%{})
    {:ok, id} = ImageUploadWorker.start_link("010101010101")
    [id: id]
  end

  test "returns internal data" do
    assert ImageUploadWorker.get_data == "010101010101"
  end

  test "sets status in ImageUploadStatus", context do
    {:ok, status} = ImageUploadStatus.status(context[:id])
    assert status == "complete"
  end
end