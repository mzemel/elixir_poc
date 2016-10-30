defmodule ImageUploadWorker.Supervisor do
  use Supervisor

  def start_link do
    :supervisor.start_link(__MODULE__, [])
  end

  def init([]) do
    pool_options = [
      name: {:local, :image_upload_worker_pool},
      worker_module: ImageUploadWorker,
      size: 10,
      max_overflow: 5
    ]

    children = [
      :poolboy.child_spec(:image_upload_worker_pool, pool_options, %{})
    ]

    supervise(children, strategy: :one_for_one)
  end
end