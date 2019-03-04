require 'rails'

require_relative 'installer'
require_relative 'middleware/ensure_connection'

module ActiveRecordServerless
  class Railtie < ::Rails::Railtie
    initializer 'active_record_serverless.install', after: 'active_record.initialize_database' do |app|
      ActiveRecordServerless::Installer.install!(app)
      app.middleware.insert_before(Rack::Runtime, ActiveRecordServerless::Middleware::EnsureConnection)
    end
  end
end
