## Ruby App

```
bundle exec rake db:create db:migrate
bundle install
brew update && brew install redis # maybe need to start server manually?
bundle install
bundle exec rspec # run tests
bundle exec sidekiq # in separate tab
bundle exec rails s
```

Must have `sidekiq` and `rails s` running concurrently to run benchmarking script.
