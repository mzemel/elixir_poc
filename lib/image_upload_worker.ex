defmodule ImageUploadWorker do
  use GenServer

  ####
  # Public interface

  def start_link(queue) do
    {:ok, _pid} = GenServer.start_link(__MODULE__, queue, name: __MODULE__)
  end

  def queue do
    GenServer.call(__MODULE__, :get_queue)
  end

  ####
  # GenServer implemetation

  def handle_call(:get_queue, _from, queue) do
    { :reply, queue, queue }
  end
end