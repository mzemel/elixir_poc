defmodule ImageUploadStatusTest do
  use ExUnit.Case

  setup do
    ImageUploadStatus.start_link(%{image_id: "done"})
    [statuses: %{image_id: "done"}]
  end

  test "is instantiated", context do
    assert ImageUploadStatus.all == context[:statuses]
  end

  test "returns {:ok, status} for ID" do
    {:ok, status} = ImageUploadStatus.fetch(:image_id)
    assert status == "done"
  end

  test "returns {:not_found, nil} when ID does not exist" do
    {code, nil} = ImageUploadStatus.fetch(:nonexistent_id)
    assert code == :not_found
  end
end