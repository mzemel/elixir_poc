defmodule ImageUploadWorkerTest do
  use ExUnit.Case
  require Logger

  # http://elixir-lang.org/docs/stable/ex_unit/ExUnit.Callbacks.html
  setup do
    ImageUploadWorker.start_link([])
    :ok
  end

  test "queue is empty" do
    assert ImageUploadWorker.queue == []
  end

  @tag :pending
  test "queue can be given data" do
  end
end