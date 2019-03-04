require_relative 'timeout'

module ActiveRecordServerless
  class Executor
    def self.setup
      ActiveRecord::Base.connection.class.class_eval do
        alias_method :serverless_execute, :execute

        def execute(*args)
          ActiveRecordServerless::Timeout.touch!

          serverless_execute(*args)
        end
      end
    end
  end
end
