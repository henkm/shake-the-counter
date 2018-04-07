#
# Configuration object for storing some parameters required for making transactions
#
module ShakeTheCounter::Config
  class << self
    attr_accessor :client_id
    attr_accessor :client_secret
    attr_accessor :refresh_token
    attr_accessor :environment
    attr_accessor :language_code
    attr_accessor :version
    attr_accessor :verbose # if set, give more output in the log/console

    # Set's the default value's to nil and false
    # @return [Hash] configuration options
    def init!
      @defaults = {
        :@refresh_token => ENV["STC_REFRESH_TOKEN"],
        :@client_id     => ENV["STC_CLIENT_ID"],
        :@client_secret => ENV["STC_CLIENT_SECRET"],
        :@language_code => "nl-NL",
        :@environment => 'test',
        :@version => 1,
        :@verbose => false,
      }
    end

    # Resets the value's to there previous value (instance_variable)
    # @return [Hash] configuration options
    def reset!
      @defaults.each { |key, value| instance_variable_set(key, value) }
    end

    # Set's the new value's as instance variables
    # @return [Hash] configuration options
    def update!
      @defaults.each do |key, value|
        instance_variable_set(key, value) unless instance_variable_defined?(key)
      end
    end
  end
  init!
  reset!
end
