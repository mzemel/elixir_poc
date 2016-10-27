defmodule PhoenixImageSvc.StatusControllerTest do
  use PhoenixImageSvc.ConnCase

  setup %{conn: conn} do
    ImageUploadStatus.start_link(%{})
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "returns status of found upload" do
    {:ok, id} = ImageUploadWorker.process(%{name: "foo"})
    conn = get conn, status_path(conn, :show, id), id: id
    assert json_response(conn, 200)["status"] == "start"
  end

  @tag :pending
  test "returns status of not found upload" do
  end
end
