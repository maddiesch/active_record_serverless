require File.expand_path('boot', __dir__)

require 'rails/all'

require 'active_record_serverless'

module Dummy
  class Application < Rails::Application
    if Rails::VERSION::MAJOR < 6
      if config.active_record.sqlite3.respond_to?(:represent_boolean_as_integer=)
        config.active_record.sqlite3.represent_boolean_as_integer = true
      end
    end
  end
end
