class UploadWorker
  include Sidekiq::Worker
  def perform(id)
    sleep 0.5
    Status.complete(id)
  end
end