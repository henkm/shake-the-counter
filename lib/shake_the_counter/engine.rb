module ShakeTheCounter
  #
  # Simpel extend on the +Rails::Engine+ to add support for a new config section within
  # the environment configs
  #
  # @example default
  #   # /config/environments/development.rb
  # config.shake_the_counter.environment  = "test"
  #
  class Engine < Rails::Engine
    config.shake_the_counter = ShakeTheCounter::Config
  end
end
