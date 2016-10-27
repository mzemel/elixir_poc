require IEx;

defmodule ImageUploadWorker do
  use GenServer

  ####
  # External API

  def start_link(data) do
    # {:ok, id} = Repo.insert(%Upload{started_at: Time.now})
    id = "some_id" # Replace with above line
    {:ok, _pid} = GenServer.start_link(__MODULE__, %{id: id, data: data}, name: __MODULE__)
    ImageUploadStatus.start(id)
    GenServer.cast(__MODULE__, :process)
    {:ok, id}
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