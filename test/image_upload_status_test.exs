defmodule ImageUploadStatusTest do
  use ExUnit.Case

  setup do
    ImageUploadStatus.start_link(%{image_id: "done"})
    [statuses: %{image_id: "done"}]
  end

  test "returns all statuses", context do
    assert ImageUploadStatus.all == context[:statuses]
  end

  test "successfully fetches a valid id" do
    {:ok, status} = ImageUploadStatus.fetch(:image_id)
    assert status == "done"
  end

  test "cannot fetch an invalid id" do
    {code, nil} = ImageUploadStatus.fetch(:nonexistent_id)
    assert code == :not_found
  end

  test "updates a status" do
    ImageUploadStatus.set(%{image_id: "initial"})
    {:ok, status} = ImageUploadStatus.fetch(:image_id)
    assert status == "initial"
  end
end