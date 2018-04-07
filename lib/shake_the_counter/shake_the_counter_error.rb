class ShakeTheCounterError < StandardError
  attr_accessor :error_message
  attr_accessor :error_code
end