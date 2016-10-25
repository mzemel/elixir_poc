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

Resources:

POST /api/uploads
  - Parameters: '{"upload": {"name": "something"}}'
  - Test with `curl -H "Content-Type: application/json" -X POST -d '{"upload":{"name":"something"}}' http://localhost:4000/api/uploads`