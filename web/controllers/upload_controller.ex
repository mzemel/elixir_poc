defmodule PhoenixImageSvc.UploadController do
  use PhoenixImageSvc.Web, :controller

  def create(conn, %{"upload" => upload_params}) do
    case ImageUploadWorker.process(upload_params) do
      {:ok, id} ->
        render conn, "show.json", id: id
      _ ->
        render conn, "show.json", id: nil
    end
  end
end
