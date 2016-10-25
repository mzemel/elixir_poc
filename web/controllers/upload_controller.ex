defmodule PhoenixImageSvc.UploadController do
  use PhoenixImageSvc.Web, :controller

  alias PhoenixImageSvc.Upload

  def create(conn, %{"upload" => upload_params}) do
    changeset = Upload.changeset(%Upload{}, upload_params)

    case Repo.insert(changeset) do
      {:ok, upload} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", upload_path(conn, :show, upload))
        |> render("show.json", upload: upload)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(PhoenixImageSvc.ChangesetView, "error.json", changeset: changeset)
    end
  end
end
