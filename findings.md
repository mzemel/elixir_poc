# Findings

## Trial 1

#### Context

Measure an IO-bound application in the main thread (e.g. database lookups)

* Pool: fixed
* IO block: 0.5s in main thread
* Users: fixed

#### Result

* Ruby: scales linearly with users
* Elixir: constant

Elixir wins.

## Trial 2

#### Context

Measure an IO-bound application in the background thread (e.g. network requests)

* Pool: variable
* IO block: 0.5s in background thread
* Users: fixed

#### Result

* Ruby: scales linearly with pool size
* Elixir: scales linearly with pool size

No winner, however Elixir can support more workers than Ruby.

## Trial 3

#### Context

Measure an application that has heavy traffic.

* Pool: 1
* IO block: None
* Users: variable

#### Findings

* Ruby: scales linearly with users.
* Elixir: scales linearly with users.

Elixir scales much better.

| Users | Elixir | Ruby |
|:------|-------:|-----:|
|10     |0.11s   |0.17s |
|100    | 0.35s  | 1.96s|
|200    | 0.62s  | 3.41s|
|1000   | 4.92s  | ???? |