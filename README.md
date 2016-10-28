Individual README files are in their folders

## Usage:

`REQUESTS=10 TARGET=elixir ruby benchmark.rb`

REQUESTS is number of concurrent requests to make
TARGET can be `elixir` or `ruby`

See the README files for app configuration for each of the two targets.

## Description:

1. Ruby script makes POST to upload endpoint
2. `UploadsController` takes the request body and tells `ImageUploadWorker` (elixir) or `Upload#create` (ruby) to process it.
3. `ImageUploadWorker#process` (elixir) or `Upload#create` (ruby) creates a record in the DB, then uses that ID to set a "start" status in `ImageUploadStatus` (elixir) or Redis (ruby).  It asynchronously begins the processing job and returns the ID to the controller, who gives it back to the user.
4. The user gets the ID and hits the status endpoint for that id continually, asking for the status, until it says "complete".
5. The background `ImageUploadWorker` (elixir) or `UploadWorker` (ruby) processes the image: modifies it, uploads to s3, then updates the `ImageUploadStatus` (elixir) or Redis (ruby) to "complete".  Right now this is stubbed with a half-second sleep.
6. The user gets a "complete" message and exists, printing the total time elapsed.