# require dependencies
require 'rest_client'
require 'json'
require 'date'

# require gem files
require "shake_the_counter/version"
require "shake_the_counter/shake_the_counter_error"
require "shake_the_counter/config"
require "shake_the_counter/engine" if defined?(Rails) && Rails::VERSION::MAJOR.to_i >= 3

# require API parts
require "shake_the_counter/api"
require "shake_the_counter/authentication"
require "shake_the_counter/client"
require "shake_the_counter/event"
require "shake_the_counter/performance"
require "shake_the_counter/section"
require "shake_the_counter/price_type"
require "shake_the_counter/reservation"
require "shake_the_counter/contact"
require "shake_the_counter/ticket"


module ShakeTheCounter

  # For testing purpose only: set the username and password
  # in environment variables to make the tests pass with your test
  # credentials.
  def self.set_credentials_from_environment
    Config.environment = :test
    Config.verbose = true
  end

end

class String
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end