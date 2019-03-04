require 'active_support'

module ActiveRecordServerless
  class Timeout
    MUTEX = Mutex.new

    class << self
      def touch!
        ActiveSupport::Notifications.instrument('active_record_serverless.touch') do
          MUTEX.synchronize do
            _last_used(Time.now)
            yield if block_given?
          end
        end
      end

      def last_used
        MUTEX.synchronize { _last_used }
      end

      def on_timeout(timeout, &block)
        raise ArgumentError, 'Timeout must be greater than 1' unless timeout.to_f >= 1.0

        touch!

        MUTEX.synchronize do
          _running_id((_running_id || 0) + 1)
        end

        _on_timeout(timeout.to_f, running_id, &block)
      end

      def running?
        running_id.positive?
      end

      def running_id
        MUTEX.synchronize { _running_id }
      end

      private

      def _on_timeout(timeout, rid, &block)
        Thread.new do
          sleep(timeout)
          last = last_used
          delta = Time.now.to_f - last.to_f
          if delta >= timeout
            opts = { last_time: last, delta: delta, running_id: rid }
            ActiveSupport::Notifications.instrument('active_record_serverless.timeout', opts) do
              yield(last, delta)
            end
          end
          _on_timeout(timeout, rid, &block) if rid == running_id
        end
      end

      def _last_used(time = nil)
        @_last_used = time unless time.nil?
        @_last_used
      end

      def _running_id(running = nil)
        @_running_id = running unless running.nil?
        @_running_id
      end
    end
  end
end
