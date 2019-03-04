require 'active_record'
require 'active_support'

require_relative 'timeout'

module ActiveRecordServerless
  def self.reconnect
    ActiveRecordServerless::Timeout.touch!

    return if ActiveRecord::Base.connected?

    ActiveSupport::Notifications.instrument('active_record_serverless.reconnect') do
      ActiveRecord::Base.establish_connection
    end
  end
end
