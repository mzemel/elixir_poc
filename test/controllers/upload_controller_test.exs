defmodule PhoenixImageSvc.UploadControllerTest do
  use PhoenixImageSvc.ConnCase

  alias PhoenixImageSvc.Upload
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, upload_path(conn, :create), upload: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Upload, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, upload_path(conn, :create), upload: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end
end
