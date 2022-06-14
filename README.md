# CryptoTransInfo

A simple Phoenix application with React and TypeScript as its frontend.
Also includes SQLite3 database for storing already processed transactions.

EtherScan API is used as data source
and the principle of lazy loading of data in the database.

Logically, we expect that the transaction has already been processed in the Ethereum network and perhaps the application database already exists, in which case we take the data from the database,
if there is no transaction in the database then
call Api EtherScan save the data and return the response to the client.

## Schema how is it works

![alt text](/priv/doc/schema.jpg ).

## Requirements

* Erlang `24.3.4.1`
* Elixir `1.13.2`
* Npm `8.5.1`

## Phoenix Backend setup

* Install dependencies with `mix deps.get`
* Compile `mix deps.compile`
* Create and migrate a database (SQLite3) with `mix ecto.migrate`
* Start the Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`
* To run tests `mix test`

## React frontend setup

For setting up the frontend:

* `mix buildfrontend`

## Visit web page

* `http:localhost:4000/app`
