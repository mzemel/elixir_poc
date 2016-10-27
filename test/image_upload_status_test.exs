defmodule ImageUploadStatusTest do
  use ExUnit.Case

  setup do
    ImageUploadStatus.clear
    ImageUploadStatus.start("image_id")
    :ok
  end

  test "returns all statuses" do
    assert ImageUploadStatus.all == %{"image_id" => "start"}
  end

  test "successfully returns status of a valid id" do
    {:ok, status} = ImageUploadStatus.status("image_id")
    assert status == "start"
  end

  test "cannot return status of an invalid id" do
    {:ok, status} = ImageUploadStatus.status("nonexistent_id")
    assert status == "not found"
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

  test "clear removes all statuses" do
    ImageUploadStatus.start("second_image_id")
    ImageUploadStatus.clear
    {:ok, status} = ImageUploadStatus.status("image_id")
    assert status == "not found"
  end
end