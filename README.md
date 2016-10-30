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

## PiDigits

This is an attempt to replace the sleep timer with something CPU-intensive to leverage BEAM using multiple cores.  Haven't worked it into the program yet but it should go in the worker functions.

To run in command line:

```
# Erlang
./build_erlang_benchmark
erl -smp disable -noshell -run  pidigits main 10000

# Ruby
ruby pidigits.rb