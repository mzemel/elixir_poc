defmodule PhoenixImageSvc.StatusController do
  use PhoenixImageSvc.Web, :controller

  def show(conn, %{"id" => id}) do
    {id, _string} = Integer.parse(id)
    {:ok, status} = ImageUploadStatus.status(id)
    render conn, "show.json", status: status
  end
end
