defmodule PhoenixImageSvc.UploadView do
  use PhoenixImageSvc.Web, :view

  def render("index.json", %{uploads: uploads}) do
    %{data: render_many(uploads, PhoenixImageSvc.UploadView, "upload.json")}
  end

  def render("show.json", %{upload: upload}) do
    %{data: render_one(upload, PhoenixImageSvc.UploadView, "upload.json")}
  end

  def render("upload.json", %{upload: upload}) do
    %{id: upload.id,
      name: upload.name}
  end
end
