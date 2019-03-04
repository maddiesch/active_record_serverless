require 'active_record'

require_relative '../timeout'

module ActiveRecordServerless
  module Middleware
    class EnsureConnection
      def initialize(app)
        @app = app
      end

      def call(env)
        ActiveRecordServerless::Timeout.touch! do
          ActiveRecord::Base.establish_connection unless ActiveRecord::Base.connected?
        end
        @app.call(env)
      end
    end
  end
end
