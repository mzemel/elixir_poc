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

  def status(id) do
    GenServer.call(__MODULE__, {:status, id})
  end

  def start(id) do
    GenServer.cast(__MODULE__, {:start, id})
  end

  def complete(id) do
    GenServer.cast(__MODULE__, {:complete, id})
  end

  def clear do
    GenServer.cast(__MODULE__, :clear)
  end

  ####
  # GenServer implementation

  def handle_call(:all, _from, statuses) do
    { :reply, statuses, statuses }
  end

  def handle_call({:status, id}, _from, statuses) do
    case Map.get(statuses, id) do
      nil -> { :reply, {:ok, "not found"}, statuses }
      status -> { :reply, {:ok, status}, statuses }
    end
  end

  def handle_cast({:start, id}, statuses) do
    { :noreply, Map.merge(statuses, %{id => "start"}) }
  end

  def handle_cast({:complete, id}, statuses) do
    { :noreply, Map.merge(statuses, %{id => "complete"}) }
  end

  def handle_cast(:clear, _statuses) do
    { :noreply, %{} }
  end
end
