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

  # def create(conn, %{"upload" => upload_params}) do
  #   {:ok, upload} = Upload.changeset(%Upload{}, %{name: "test"}) |> Repo.insert
  #   :poolboy.transaction(:image_upload_worker_pool, fn(worker) -> :gen_server.call(worker, :process, %{id: upload.id, image: upload_params}) end)
  #   render conn, "show.json", id: upload.id
  # end
end
