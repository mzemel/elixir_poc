defmodule PhoenixImageSvc.StatusView do
  use PhoenixImageSvc.Web, :view

  def render("show.json", %{status: status}) do
    %{status: status}
  end

end
