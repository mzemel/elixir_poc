# PhoenixImageSvc

To start:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
    * Note: I had to add a postgres role to my database with password 'postgres'
    * Then give it createdb and login grants (e.g. ALTER ROLE postgres LOGIN)
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.