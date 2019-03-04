module ActiveRecordServerless
  def self.log(msg)
    if defined?(::Rails)
      ::Rails.logger.debug msg
    else
      STDERR.puts msg
    end
  end
end
