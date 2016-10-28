defmodule PhoenixImageSvc.UploadControllerTest do
  use PhoenixImageSvc.ConnCase

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  @tag :pending
  test "starts a link to ImageUploadWorker", %{conn: conn} do
    conn = post conn, upload_path(conn, :create), upload: @valid_attrs
    # assert_receive
  end

  @tag :pending
  test "sends process to ImageUploadWorker", %{conn: conn} do
    conn = post conn, upload_path(conn, :create), upload: @valid_attrs
    # assert_receive
  end

  test "renders json of the upload id", %{conn: conn} do
    conn = post conn, upload_path(conn, :create), upload: @valid_attrs
    assert json_response(conn, 200)["id"]
  end
end
