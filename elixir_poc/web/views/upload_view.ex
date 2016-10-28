defmodule PhoenixImageSvc.UploadView do
  use PhoenixImageSvc.Web, :view

  def render("show.json", %{id: id}) do
    %{id: id}
  end
end
