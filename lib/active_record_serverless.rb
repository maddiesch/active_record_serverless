require 'active_record_serverless/installer'
require 'active_record_serverless/reconnect'
require 'active_record_serverless/timeout'
require 'active_record_serverless/version'

require 'active_record_serverless/railtie' if defined?(::Rails)

module ActiveRecordServerless
  class Error < StandardError; end
end
