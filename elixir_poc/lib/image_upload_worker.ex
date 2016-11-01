require IEx;

defmodule ImageUploadWorker do
  use GenServer

  alias PhoenixImageSvc.Upload
  alias PhoenixImageSvc.Repo

  ####
  # External API

  def start_link(data) do
    GenServer.start_link(__MODULE__, data, name: __MODULE__)
  end

  def process(data \\ nil) do
    # TODO: Remove `name` attribute
    {:ok, upload} = Upload.changeset(%Upload{}, %{name: "test"}) |> Repo.insert
    ImageUploadStatus.start(upload.id)
    # :timer.sleep(500)
    GenServer.cast(__MODULE__, {:process, %{id: upload.id, image: data}})
    {:ok, upload.id}
  end
    
  def image do
    GenServer.call(__MODULE__, :image)
  end

  ####
  # GenServer implemetation

  def handle_call(:image, _from, state) do
    { :reply, state[:image], state }
  end

  def handle_cast({:process, data}, _state) do
    # Process image
    # Upload to S3
    # :timer.sleep(500)
    ImageUploadStatus.complete(data[:id])
    # { :noreply, %{id: nil, image: nil} } # This would reset the state to empty
    { :noreply, data }
  end
end