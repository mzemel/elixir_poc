defmodule ImageUploadWorker do
  use GenServer

  alias PhoenixImageSvc.Upload
  alias PhoenixImageSvc.Repo

  ####
  # External API

  def start_link(data) do
    # TODO: Remove `name` attribute
    {:ok, upload} = Upload.changeset(%Upload{}, %{name: "test"}) |> Repo.insert
    GenServer.start_link(__MODULE__, %{id: upload.id, data: data}, name: __MODULE__)
    ImageUploadStatus.start(upload.id)
    GenServer.cast(__MODULE__, :process)
    {:ok, upload.id}
  end

  def get_data do
    GenServer.call(__MODULE__, :get_data)
  end

  ####
  # GenServer implemetation

  def handle_call(:get_data, _from, state) do
    { :reply, state[:data], state }
  end

  def handle_cast(:process, state) do
    # Process image
    # Upload to S3
    # Update record in db w/ public URL
    ImageUploadStatus.complete(state[:id])
    { :noreply, state }
  end
end