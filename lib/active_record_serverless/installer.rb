require 'active_record'

require_relative 'timeout'
require_relative 'logger'
require_relative 'executor'

module ActiveRecordServerless
  def self.start_timeout(timeout = nil)
    ActiveRecordServerless::Installer.start_timeout(timeout)
  end

  class Installer
    class << self
      def config
        ActiveRecord::Base.connection_config.with_indifferent_access.dig(:serverless)
      end

      def install!(_app)
        disabled = config.dig(:disabled).nil? ? false : config.dig(:disabled)

        if disabled == true
          message = <<~EOF
            Skipping ActiveRecordServerless Install.

            Connection config explicitly marked serverless as disabled.
          EOF
          ActiveRecordServerless.log(message)
          return
        end

        _install
      end

      def start_timeout(timeout = nil)
        timeout ||= (config.dig(:timeout) || 60.0)

        ActiveRecordServerless.log("Installing ActiveRecordServerless [timeout=#{timeout}]")

        ActiveRecordServerless::Timeout.on_timeout(timeout) do
          ActiveRecordServerless.log('ActiveRecordServerless timeout...')
          ActiveRecord::Base.connection_pool.disconnect!
        end
      end

      private

      def _install
        ActiveRecordServerless::Executor.setup
        ActiveRecordServerless::Installer.start_timeout
      end
    end
  end
end
