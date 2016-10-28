## Ruby App

```
bundle install
brew update && brew install redis # maybe need to start server manually?
bundle install
bundle exec rspec # run tests
bundle exec sidekiq # in separate tab
```

Run benchmark with `REQUESTS=10 TARGET=ruby ruby benchmark.rb`

Benchmark file can be found in Elixir folder.