module ShakeTheCounter
  #
  # Simpel extend on the +Rails::Engine+ to add support for a new config section within
  # the environment configs
  #
  # @example default
  #   # /config/environments/development.rb
  # config.prioticket.api_key  = "12343465sdfgsadr324"
  #
  class Engine < Rails::Engine
    config.shake_the_counter = ShakeTheCounter::Config
  end
end
