# PhoenixImageSvc

To start:

  * Install dependencies with `mix deps.get, deps.compile`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
    * Note: I had to add a postgres role to my database with password 'postgres'
    * Then give it createdb and login grants (e.g. ALTER ROLE postgres LOGIN)
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Run tests with `mix test path/to/test.exs`

## General flow:

1. Ruby script makes POST to `/api/uploads`
2. `UploadsController` takes the request body and tells `ImageUploadWorker` to process it.
3. `ImageUploadWorker#process` creates a record in the DB, then uses that ID to set a "start" status in `ImageUploadStatus`.  It asynchronously begins the processing job (using `GenServer.cast`) and returns the ID to the controller, who gives it back to the user.
4. The user gets the ID and hits `/api/status/:id` continually, asking for the status, until it says "complete".
5. The background `ImageUploadWorker` processes the image: modifies it, uploads to s3, then updates `ImageUploadStatus` to "complete".  Right now this is stubbed with a `:timer.sleep(:500)`.
6. The user gets a "complete" message and finishes.