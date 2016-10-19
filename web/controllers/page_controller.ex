defmodule PhoenixImageSvc.PageController do
  use PhoenixImageSvc.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
