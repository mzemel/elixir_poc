defmodule ImageUploadWorkerTest do
  use ExUnit.Case

  # http://elixir-lang.org/docs/stable/ex_unit/ExUnit.Callbacks.html
  setup do
    ImageUploadWorker.start_link([])
    :ok
  end

  test "queue is empty" do
    assert ImageUploadWorker.queue == []
  end

  test "queue can be given data" do
    ImageUploadWorker.push("Foo")
    assert ImageUploadWorker.queue == ["Foo"]
  end
end