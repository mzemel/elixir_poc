defmodule PhoenixImageSvc.Router do
  use PhoenixImageSvc.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixImageSvc do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", PhoenixImageSvc do
    pipe_through :api

    resources "/uploads", UploadController, only: [:create]
    resources "/status", StatusController, only: [:show]
  end
end
