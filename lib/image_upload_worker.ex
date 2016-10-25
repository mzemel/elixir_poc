defmodule ImageUploadWorker do
  use GenServer

  ####
  # External API

  def start_link(queue) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, queue, name: __MODULE__)
  end

  def queue do
    GenServer.call(__MODULE__, :queue)
  end

  def push(item) do
    GenServer.cast(__MODULE__, {:push, item})
  end

  ####
  # GenServer implemetation

  def handle_call(:queue, _from, queue) do
    { :reply, queue, queue }
  end

  def handle_cast({:push, item}, statuses) do
    { :noreply, Enum.into(statuses, [item]) }
  end
end