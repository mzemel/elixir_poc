defmodule ImageUploadStatus do
  use GenServer

  ####
  # External API

  def start_link(statuses) do
    GenServer.start_link(__MODULE__, statuses, name: __MODULE__)
  end

  def all do
    GenServer.call(__MODULE__, :all)
  end

  def fetch(id) do
    GenServer.call(__MODULE__, {:fetch, id})
  end

  def set(update) do
    GenServer.cast(__MODULE__, {:set, update})
  end

  ####
  # GenServer implementation

  def handle_call(:all, _from, statuses) do
    { :reply, statuses, statuses }
  end

  def handle_call({:fetch, id}, _from, statuses) do
    case Map.get(statuses, id) do
      nil -> { :reply, {:not_found, nil}, statuses }
      status -> { :reply, {:ok, status}, statuses }
    end
  end

  def handle_cast({:set, update}, statuses) do
    { :noreply, Map.merge(statuses, update) }
  end

end
