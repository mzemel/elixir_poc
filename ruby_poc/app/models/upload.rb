class Upload < ActiveRecord::Base
  def self.create(options)
    record = super(options)
    Status.start(record.id)
    # sleep 0.5
    UploadWorker.perform_async(record.id)
    record
  end
end
