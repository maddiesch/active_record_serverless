# ActiveRecordServerless

Handles database connection's to disconnect on a timeout. This allows [Aurora Serverless](https://aws.amazon.com/rds/aurora/serverless/) servers to spin down.

## Installing

In a Gemfile

```ruby
gem 'active_record_serverless'
```

Manually

`gem install active_record_serverless`

### Config

```ruby
# in config/database.yml
development:
  # other db params
  serverless:
    timeout: 60.0 # Timeout every 60 seconds.
```

### Forking

```ruby
after_fork do
  ActiveRecordServerless.start_timeout
end
```

### Non-Rails Application.

#### Setup

```ruby
ActiveRecordServerless::Installer.install!(nil)
```
