defmodule ImageUploadStatusTest do
  use ExUnit.Case

  setup do
    ImageUploadStatus.start_link(%{"image_id" => "start"})
    [statuses: %{"image_id" => "start"}]
  end

  test "returns all statuses", context do
    assert ImageUploadStatus.all == context[:statuses]
  end

  test "successfully returns status of a valid id" do
    {:ok, status} = ImageUploadStatus.status("image_id")
    assert status == "start"
  end

  test "cannot return status of an invalid id" do
    {code, nil} = ImageUploadStatus.status("nonexistent_id")
    assert code == :not_found
  end

  test "adds a status as start" do
    ImageUploadStatus.start("second_image_id")
    {:ok, status} = ImageUploadStatus.status("second_image_id")
    assert status == "start"
  end

  test "transitions status to complete" do
    ImageUploadStatus.complete("image_id")
    {:ok, status} = ImageUploadStatus.status("image_id")
    assert status == "complete"
  end
end